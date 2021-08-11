class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  def index
    @events = Event.all

    render json: @events
  end

  # GET /events/today
  def today
    @events = Event.where(:created_at => (Time.now.midnight.utc..(Time.now.midnight + 1.day).utc))
    clicks = 0
    views = 0

    @events.each do |event|
      if event[:event_type].downcase == "click"
        clicks += 1
      elsif event[:event_type].downcase == "view"
        views += 1
      end  
    end

    render json: {EG: {todays_stats: [{click: clicks}, {view: views}]}}
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit!
      { name: params[:event][:name], event_type: params[:event][:event_type], raw_data: params[:event].to_json}
    end
end
