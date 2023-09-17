class GoogleCalendarService
  attr_reader :access_token, :calendar_id

  def initialize(access_token, calendar_id)
    @access_token = access_token
    @calendar_id = calendar_id
  end

  def conn
    Faraday.new(url: 'https://www.googleapis.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def get_url(url)
    response = conn.get do |req|
      req.url url
      req.headers['Authorization'] = "Bearer #{access_token}"
      req.headers['Content-Type'] = 'application/json'
    end

    if response.status == 200
      JSON.parse(response.body, symbolize_names: true)
    else
      puts "Failed to fetch data. Error #{response.status}"
      nil
    end
  end

  def calendar_events
    get_url("/calendar/v3/calendars/#{calendar_id}/events")
  end
end