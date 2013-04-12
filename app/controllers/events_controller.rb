class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @wednesday = Event.on_wednesday
    @thursday = Event.on_thursday
    @friday = Event.on_friday
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end
end
