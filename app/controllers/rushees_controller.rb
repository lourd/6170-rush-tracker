class RusheesController < ApplicationController

	before_action :set_rushee, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_brother!

	def index
  	@rushees = current_brother.fraternity.rushees
	end

	def new
		@rushee = Rushee.new
		@brothers = current_brother.fraternity.brothers
	end

	def create

		# Check if the email given for a brother is valid before saving
		if rushee_params[:primary_contact_brother].present?
			primary_contact = Brother.find_by_email(rushee_params[:primary_contact_brother])
			if primary_contact
	    	@rushee = Rushee.new(rushee_params.merge(:fraternity_id => current_brother.fraternity_id, :primary_contact_id => primary_contact.id, :action_status => "None", :bid_status => "None"))
	    	if @rushee.save
	    		redirect_to @rushee, notice: 'Rushee was successfully created.'
	    	else
	    		flash[:alert] = 'That email does not exist for a Brother'
	    		render action: 'new'
	    	end
	    else
	    	@rushee = Rushee.new(rushee_params.merge(:fraternity_id => current_brother.fraternity_id, :action_status => "None", :bid_status => "None"))
	    	flash[:alert] = 'That email does not exist for a Brother'
	    	render action: 'new'
	    end
	  else
	  	@rushee = Rushee.new(rushee_params.merge(:fraternity_id => current_brother.fraternity_id, :action_status => "None", :bid_status => "None"))
	  	if @rushee.save
	  		redirect_to @rushee, notice: 'Rushee was succesfully created'
	  	else
	  		flash[:alert] = 'That email does not exist for a Brother'
	    	render action: 'new'
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

	def show
		@comments = @rushee.comments
	end

	def update
		primary_contact = Brother.find_by_email(rushee_params[:primary_contact_brother])
		if primary_contact
    	@rushee = Rushee.new(rushee_params.merge(:fraternity_id => current_brother.fraternity_id, :primary_contact_id => primary_contact.id, :action_status => "None", :bid_status => "None"))
    else
    	@rushee = Rushee.new(rushee_params.merge(:fraternity_id => current_brother.fraternity_id, :action_status => "None", :bid_status => "None"))
    end
		if @rushee.update(rushee_params)
			redirect_to @rushee, notice: 'Rushee was successfully updated'
		else
			redirect_to @rushee, notice: 'Rushee was not successfully updated'
		end
	end

	private
	# Never trust parameters from the scary internet, only allow the white list through.
	  def rushee_params
	    params.require(:rushee).permit(:firstname, :lastname, :email, :cellphone, :facebook_url, :twitter_url, :profile_picture_url, :dorm, :room_number, :hometown, :sports, :frats_rushing, :primary_contact_id, :primary_contact_brother)
	  end

	    # Use callbacks to share common setup or constraints between actions.
	  def set_rushee
	    @rushee = Rushee.find(params[:id])
	  end
end
