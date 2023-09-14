class HolidaysSerializer
  def initialize(holidays)
    @holidays = holidays
  end
  
  def as_json
    {
      'data': @holidays.map do |holiday|
                {
                  'type': 'holiday',
                  'attributes': {
                    'name': holiday.name,
                    'date': holiday.date
                  }
                }
              end
    }
  end
end
