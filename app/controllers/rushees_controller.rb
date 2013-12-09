class RusheesController < ApplicationController

  layout 'application', except: :present
	before_filter :authenticate_brother!
  before_filter :is_verified!
  before_action :set_rushee, only: [:show, :edit, :update, :destroy, :upVote, :removeVote, :meet, :unmeet, :getApproval]
    #except: [:index, :new, :present, :create]

	def index
    @rushees = current_brother.fraternity.rushees
    @actions = Action.where( brother_id: current_brother.id ).order(:created_at)
    @max_feed = 5  
	end

	def show
		@comments = @rushee.comments
	end

	def new
		@rushee = Rushee.new
		@brothers = current_brother.fraternity.brothers
	end

	def create
		@rushee = Rushee.new(rushee_params)
		respond_to do |format|
			if @rushee.save(rushee_params)
				format.html { redirect_to @rushee, notice: 'Rushee was successfully created.' }
				format.json { render action: 'show', status: :created, location: @rushee }

        action = Action.new
        action.brother_id = @rushee.primary_contact_id
        action.rushee_id = @rushee.id 
        action.date = Time.now
        action.description = "You're a primary contact for " + @rushee.fullName + "."
        action.save()
			else
				format.html { render action: 'new' }
				format.json { render json: @rushee.errors, status: :unprocessable_entity }
			end
		end
	end

	def edit
	end

	def delete
	end

  def update
    send_reminder = false
    old_bro = @rushee.primary_contact_id
    new_bro = params[:rushee][:primary_contact_id]
    if old_bro != new_bro
      send_reminder = true
    end

    respond_to do |format|
      if @rushee.update(rushee_params)
        format.html { redirect_to @rushee, notice: 'Rushee was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @rushee }

        if send_reminder
          # create action for whoever gets the rushee 
          action = Action.new
          action.brother_id = new_bro
          action.rushee_id = @rushee.id 
          action.date = Time.now
          action.description = "You're a primary contact for " + @rushee.fullName + "."
          action.save()

          # notify the other guy that the rushee doesn't belong to him anymore
          action2 = Action.new
          action2.brother_id = old_bro
          action2.rushee_id = @rushee.id
          action2.date = Time.now
          action2.description = "You are no longer primary contact for " + @rushee.fullName + "."
          action2.save()
        end

      else
        format.html { render action: 'new' }
        format.json { render json: @rushee.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if current_brother.is_admin 
      @rushee.destroy
      redirect_to rushees_path
    end
  end
  
  # Comment Related Methods
  def comment
    comment = Comment.new
    comment.rushee_id = params[:id]
    comment.brother_id = current_brother.id
    comment.text = params[:text]
    comment.save
    
    redirect_to "/rushees/"+comment.rushee_id.to_s
  end

  def commentDestroy
  	@comment = Comment.find(params[:comment_id])
  	@comment.destroy
  end

  #Presentation View
  def present
    @rushees = current_brother.fraternity.rushees
    respond_to do |format|
      format.html { render :layout => false }
      format.json { render json: @rushees }
    end
  end

  #Actions to Change Vote and Met Brother Counts
  def upVote
    current_brother.upVote(@rushee)
    redirect_to :back
  end

  def removeVote
    current_brother.removeVote(@rushee)
    redirect_to :back
  end

  def meet
    current_brother.meet(@rushee)
    redirect_to :back
  end

  def unmeet
    current_brother.unmeet(@rushee)
    redirect_to :back
  end

  def getApproval
    if current_brother.approvals.where(rushee: @rushee).exists?
      @approval = current_brother.approvals.where(rushee: @rushee)  
    else
      current_brother.unmeet(@rushee)
      @approval = current_brother.approvals.where(rushee: @rushee)
    end
    render json: @approval
  end

  #Helper Functions

	private
	# Never trust parameters from the scary internet, only allow the white list through.
  def rushee_params
    params.require(:rushee).permit(:firstname, :lastname, :email, :cellphone, 
    	:facebook_url, :twitter_url, :picture, :dorm, :room_number, 
    	:hometown, :sports, :frats_rushing, :primary_contact_id, :fraternity_id,
    	:action_status, :bid_status)
  end

	# Use callbacks to share common setup or constraints between actions.
	def set_rushee
	  @rushee = Rushee.find(params[:id])
	end
         
  def is_verified!
    if !current_brother.is_verified    
      sign_out current_brother
      flash[:error] = "Your account has not been verified yet."
      redirect_to :root
      return
    end
  end
end
