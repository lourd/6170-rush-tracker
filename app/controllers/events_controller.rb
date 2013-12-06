class EventsController < ApplicationController
  before_filter :authenticate_brother!
  before_filter :is_verified!
  
  def index
    @events = Event.findAllByFraternityID current_brother.fraternity_id
  end

  def new
    if ! current_brother.is_admin
      redirect_to rushees, notice: 'Only admins may create events'

    @event = Event.new
  end

  def create
    if ! current_brother.is_admin
      redirect_to rushees, notice: 'Only admins may create events'

    @event = Event.new(event_params)

    if @event.save(event_params)
      redirect_to rushees, notice: 'Event was succesfully created'
    else
      redirect_to rushees, notice: 'Event was not succesfully created'

  def edit

  end

  def delete
  end
  
    
  private 

  def event_params
    params.require(:event).permit(:name, :date)

  def is_verified!
    if !current_brother.is_verified    
      sign_out current_brother
      redirect_to :root
      return
    end
  end

end
