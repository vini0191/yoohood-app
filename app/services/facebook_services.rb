class FacebookServices
  def initialize(token)
    @access_token = token
    url = "https://graph.facebook.com/v4.0/me?fields=events.limit(100){cover,description,end_time,event_times,name,place,start_time,ticket_uri,type,admins}&access_token=#{@access_token}"
    serialized = open(url).read
    @json_events = JSON.parse(serialized)['events']['data'].reject { |event| Event.all.include? Event.find_by_fb_event_id(event['id']) }
  end

  def pull_fb_events
    @events = []
    @places = []
    @json_events.each do |json_event|
      @events << Event.new(
        title: json_event['name'],
        description: json_event['description'],
        end_time: json_event['end_time'],
        start_time: json_event['start_time'],
        cover: json_event['cover']['source'],
        fb_event_id: json_event['id'],
        places_attributes: [{
          name: json_event['place']['name'],
          address: json_event['place']['location'].present? ? json_event['place']['location']['street'] : '',
          city: json_event['place']['location'].present? ? json_event['place']['location']['city'] : '',
          state: json_event['place']['location'].present? ? json_event['place']['location']['state'] : '',
          country: json_event['place']['location'].present? ? json_event['place']['location']['country'] : '',
          latitude: json_event['place']['location'].present? ? json_event['place']['location']['latitude'] : '',
          longitude: json_event['place']['location'].present? ? json_event['place']['location']['longitude'] : ''
        }]
      )
    end
    @events
  end

  # def pull_fb_events_place
  #   @events = []
  #   @json_events.each do |json_event|
  #     @events << Event.new(
  #       title: json_event['name'],
  #       description: json_event['description'],
  #       end_time: json_event['end_time'],
  #       start_time: json_event['start_time'],
  #       cover: json_event['cover']['source'],
  #       fb_event_id: json_event['id']
  #     )
  #   end
  #   @events
  # end
end
