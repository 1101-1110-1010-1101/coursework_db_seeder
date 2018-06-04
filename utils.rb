require 'faker'
require 'active_support/all'

Time::DATE_FORMATS[:default] = '%F %T' # ISO8601 without a timezone

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

class DateRangeGenerator
  def initialize
    @occupied_ranges = []
  end

  # Accept :even_years or :odd_years
  def limited_to(year_kind)
    @limited_to = year_kind
    self
  end

  def gen(from, offset)
    departed_on, returned_on = if 90.percent_chance
        departed_on = date_between(from, Date.today)
        returned_on = Faker::Time.between(departed_on, departed_on.to_time + offset, :all)
        [departed_on, returned_on]
      else
        [Faker::Time.between(offset.ago, Date.today, :all), nil]
      end
    return gen(from, offset) if @limited_to == :even_years && departed_on.year.odd? || @limited_to == :odd_years && departed_on.year.even?
    return gen(from, offset) if @occupied_ranges.any? { |v| includes?(v, departed_on) || includes?(v, returned_on) }
    @occupied_ranges << [departed_on, returned_on]
    [departed_on, returned_on].map { |d| d&.to_s }
  end

  def includes?(range, date)
    if date == nil
      return false
    else
      date >= range.first && (range.last.nil? || date <= range.last)
    end
  end
end


class Array
  def sample_with_index
    Random.rand(0..self.size - 1).yield_self { |i| [self[i], i] }
  end
end
