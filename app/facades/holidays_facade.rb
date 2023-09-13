class HolidaysFacade
  def self.upcoming_holidays
    service = HolidaysService.new
    raw_holidays = service.upcoming_holidays
    raw_holidays.map do |holiday|
      Holiday.new(holiday)
    end
  end
end