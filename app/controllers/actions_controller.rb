class ActionsController < ApplicationController
  before_filter :authenticate_brother!
  before_filter :is_verified!
 
  
  def new
    @action = Action.new
  end


  def create
    @action = Action.new(action_params)
    @action.save(action_params)
    @action = Action.new
  end

  private 
  def action_params
    params.require(:actionr).permit(:rushee_id, :brother_id, :description)
  end


  def is_verified!
    if !current_brother.is_verified    
      sign_out current_brother
      redirect_to :root
      return
    end
  end


end
