class EventsController < ApplicationController
  before_filter :authenticate_brother!

  def index
    @events = Event.findAllByFraternityID current_brother.fraternity_id
  end

  def new
  end

  def edit
  end

  def delete
  end
end
