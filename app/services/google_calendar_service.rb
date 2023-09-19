class GoogleCalendarService

  def initialize(user)
    @user = user
  end

  def connection
    Faraday.new("https://www.googleapis.com/calendar/v3/") do |faraday|
      faraday.headers["Authorization"] = "Bearer #{@user.token}"
    end
  end

  def fetch_events
    response = connection.get("calendars/#{@user.email}/events")
    JSON.parse(response.body)
  end  
end