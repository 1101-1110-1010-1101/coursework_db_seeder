require 'faker'
require 'active_support/all'

def date_between(start_date, end_date)
  Faker::Time.between(start_date.to_datetime, end_date.to_datetime)
end

class Integer
  def percent_chance()
    Random.rand(0..100) < self
  end
end

class Range
  def sample
    Random.rand(self)
  end
end

class DateRange
  def new(date_f, date_s)
    @start = date_f
    @end = date_s
  end

  def includes?(date)
    date >= @start && (@end.nil? || date <= @end)
  end
end
