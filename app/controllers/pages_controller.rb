class PagesController < ApplicationController
  before_action :set_locale
  skip_before_action :authenticate_user!, only: %i[home members]

  def home
    @page_name = 'Find a perfect event'
    @events = Event.all.reject { |event| event.end_time.present? && event.end_time <= Time.now.getutc() }
    # @event_near = Event.all.select{ |event| event.places.city ==  }
    @events_recent = @events.sort_by { |event| event.created_at }.reverse.first(8)
    @events_today = @events.select { |event| Date.parse(event.start_time.to_s) == Date.today }
    @events_coming_up = (@events.select { |event| event.start_time > DateTime.now }.sort_by { |event| event.start_time } - @events_today).first(16)
    @events_diff = (@events - @events_recent - @events_coming_up).first(16)
    @city = request.location.city
    @nearby_events = Place.near(@city, 10).map(&:event)
  end

  def members
    @page_name = 'members'
  end

  def about
  end

  def profile
    # @meta_title = "#{DEFAULT_META["meta_product_name"]} - #{current_user.name.split(' ').first}'s profile"
    @accepted_invites = current_user.invites.select { |invite| invite.status == 'accepted' }
  end

  def set_locale
    I18n.locale = params.fetch(:locale, I18n.default_locale).to_sym
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end
end
