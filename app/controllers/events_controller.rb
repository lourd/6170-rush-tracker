class EventsController < ApplicationController
  before_filter :authenticate_brother!
  before_filter :is_verified!
  
  def index
    @events = current_brother.fraternity.events
  end

  def new
    if !current_brother.is_admin
      redirect_to events_path, notice: 'Only admins may create events'
    end

    @event = Event.new
  end

  def create
    if !current_brother.is_admin
      redirect_to events_path, notice: 'Only admins may create events'
    end

    @event = Event.new(event_params)

    if @event.save(event_params)
      redirect_to events_path, notice: 'Event was succesfully created'
    else
      redirect_to events_path, notice: 'Event was not succesfully created'
    end
  end

  def show
    @event = Event.find(params[:id])
    @rushees = @event.rushees
  end

  def addRushee
    # Add Rushee
  end

  def edit
  end

  def delete
  end
  
  private 

  def event_params
    params.require(:event).permit(:name, :date, :fraternity_id)
  end

  def is_verified!
    if !current_brother.is_verified    
      sign_out current_brother
      redirect_to :root
      return
    end
  end

end
