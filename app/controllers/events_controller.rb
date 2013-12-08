class EventsController < ApplicationController
  before_filter :authenticate_brother!
  before_filter :is_verified!
  
  def index
    @events = current_brother.fraternity.events
  end

  def new
    if !current_brother.is_admin
      redirect_to events_path, alert: 'Only admins may create events'
    end

    @event = Event.new
  end

  def create
    if !current_brother.is_admin
      redirect_to events_path, alert: 'Only admins may create events'
    end

    @event = Event.new(event_params)

    if @event.save(event_params)
      redirect_to events_path, alert: 'Event was succesfully created'
    else
      redirect_to events_path, alert: 'Event was not succesfully created'
    end
  end

  def show
    @event = Event.find(params[:id])
    @rushees = @event.rushees
    @attendance = Attendance.new
  end

  # Add a given rushee by name or email
  def addRushee
    @event = Event.find(params[:event_id])
    rushee = Rushee.find(params[:attendance][:rushee_id])
    @event.addRushee(rushee)
    redirect_to event_path(@event), alert: 'Rushee was added'
    
    rescue ActiveRecord::RecordNotFound
      redirect_to event_path(@event), alert: 'No Rushee was specified'

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
