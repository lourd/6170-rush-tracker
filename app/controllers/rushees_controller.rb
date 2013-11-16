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
			primary_contact = Brother.find_by_email(rushee_params[:primary_contact_brother])
			if primary_contact
	    	@rushee = Rushee.new(rushee_params.merge(:fraternity_id => current_brother.fraternity_id, :primary_contact_id => primary_contact.id, :action_status => "None", :bid_status => "None"))
	    else
	    	@rushee = Rushee.new(rushee_params.merge(:fraternity_id => current_brother.fraternity_id, :action_status => "None", :bid_status => "None"))
	    end
	    respond_to do |format|
	      if @rushee.save
	        format.html { redirect_to @rushee, notice: 'Rushee was successfully created.' }
	        format.json { render action: 'show', status: :created, location: @rushee }
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

	def show
		@comments = @rushee.comments
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
