class RusheesController < ApplicationController

	before_action :set_rushee, only: [:show, :edit, :update, :destroy]
  layout 'application', except: :present
	before_filter :authenticate_brother!
  before_filter :is_verified!

	def index
  		@rushees = current_brother.fraternity.rushees
      @cols = 3
	end

	def new
		@rushee = Rushee.new
		@brothers = current_brother.fraternity.brothers
	end

	def create
		# Check if the email given for a brother is valid before saving
		# if rushee_params[:primary_contact_brother].present?
		# 	primary_contact = Brother.find_by_email(rushee_params[:primary_contact_brother])
		# 	if primary_contact
	 #    	@rushee = Rushee.new(rushee_params.merge(:fraternity_id => current_brother.fraternity_id, :primary_contact_id => primary_contact.id, :action_status => "None", :bid_status => "None"))
	 #    	if @rushee.save
	 #    		redirect_to @rushee, notice: 'Rushee was successfully created.'
	 #    	else
	 #    		flash[:alert] = 'Rushee was not successfully created'
	 #    		render action: 'new'
	 #    	end
	 #    else
	 #    	@rushee = Rushee.new(rushee_params.merge(:fraternity_id => current_brother.fraternity_id, :action_status => "None", :bid_status => "None"))
	 #    	flash[:alert] = 'That email does not exist for a Brother'
	 #    	render action: 'new'
	 #    end
	 #  else
	 #  	@rushee = Rushee.new(rushee_params.merge(:fraternity_id => current_brother.fraternity_id, :action_status => "None", :bid_status => "None"))
	 #  	if @rushee.save
	 #  		redirect_to @rushee, notice: 'Rushee was successfully created'
	 #  	else
	 #  		flash[:alert] = 'Rushee was not successfully created'
	 #    	render action: 'new'
	 #  	end
	 #  end
		@rushee = Rushee.new(rushee_params)
		respond_to do |format|
			if @rushee.save(rushee_params)
				format.html { redirect_to @rushee, notice: 'Rushee was successfully created.' }
				format.json { render action: 'show', status: :created, location: @rushee }
			else
				format.html { render action: 'new' }
				format.json { render json: @rushee.errors, status: :unprocessable_entity }
			end
		end
	end

	def edit
		@rushee = Rushee.find(params[:id])
	end

	def delete
	end
  
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


	def show
		@comments = @rushee.comments
	end

  def present
    @rushees = current_brother.fraternity.rushees
    respond_to do |format|
      format.html { render :layout => false }
      format.json { render json: @rushees }
    end
  end

	def update
		# puts '>>>>>>>>>>>>>>>>> Rushee Params are <<<<<<<<<<<<<<<<<'
		# puts rushee_params
		# if rushee_params[:primary_contact_brother].present?
		# 	primary_contact = Brother.find_by_email(rushee_params[:primary_contact_brother])
		# 	if primary_contact
		# 		puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Primary Contact exists <<<<<<<<<<<<<<<<<<<<<<<<<<<'
	 #    	if @rushee.update(rushee_params.merge(:primary_contact_id => primary_contact.id))
	 #    		redirect_to @rushee, notice: 'Rushee was successfully updated.'
	 #    	else
	 #    		flash[:alert] = 'Rushee was not successfully updated'
	 #    		render action: 'edit'
	 #    	end
	 #    else
	 #    	flash[:alert] = 'That email does not exist for a Brother'
	 #    	render action: 'edit'
	 #    end
	 #  else
	 #  	puts '>>>>>> No primary contact brother <<<<<<<'
	 #  	if @rushee.update(rushee_params.merge(:primary_contact_id => nil))
	 #  		puts '>>>>>>> We are here <<<<<<<<<<<'
	 #  		redirect_to @rushee, notice: 'Rushee was successfully updated'
	 #  	else
	 #  		flash[:alert] = 'Rushee was not successfully updated'
	 #    	render action: 'edit'
	 #  	end
	 #  end
		respond_to do |format|
			if @rushee.update(rushee_params)
			format.html { redirect_to @rushee, notice: 'Rushee was successfully updated.' }
			format.json { render action: 'show', status: :created, location: @rushee }
			else
			format.html { render action: 'new' }
			format.json { render json: @rushee.errors, status: :unprocessable_entity }
			end
	  end
	end

  def delete
    if current_brother.is_admin 
      id = params[:id]
      Rushee.destroy(id)
    end
    redirect_to rushees_path
  end

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
