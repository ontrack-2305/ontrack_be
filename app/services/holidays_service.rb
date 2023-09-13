class HolidaysService
  def conn
    Faraday.new(url: "https://date.nager.at")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def upcoming_holidays
    get_url("Api/v3/NextPublicHolidays/US")
  end
end