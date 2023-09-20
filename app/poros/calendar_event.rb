class CalendarEvent
  attr_reader :name,
              :start_date,
              :description

  def initialize(data)
    @name = data["summary"]
    @start_date = data["start"]["dateTime"]
    @description = data["description"]
  end

  def formatted_start_date
    DateTime.parse(start_date).strftime("%m/%d/%Y %H:%M:%S")
  end
end