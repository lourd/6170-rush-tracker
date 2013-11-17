class EventsController < ApplicationController
  before_filter :authenticate_brother!
  before_filter :is_verified!
  
  def index
    @events = Event.findAllByFraternityID current_brother.fraternity_id
  end

  def new
  end

  def edit
  end

  def delete
  end
  
    
  private 
  def is_verified!
    if !current_brother.is_verified    
      sign_out current_brother
      redirect_to :root
      return
    end
  end

end
