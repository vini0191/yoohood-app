class EventCategoriesController < ApplicationController
  before_action :set_event, only: %i[update]
  def create
    raise
  end

  def update
    # @event.categories = []
    # params[:event][:category_ids].each do |category|
    #   next if category.empty?

    #   @event.categories << Category.find(category)
    # end

    EventCategory.create(event_id: @event.id, category_id: params[:event][:categories])
    respond_to do |format|
      format.html { redirect_to event_path(@event) }
      format.js
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
