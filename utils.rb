require 'faker'
require 'active_support/all'

def date_between(start_date, end_date)
  Faker::Time.between(start_date.to_datetime, end_date.to_datetime)
end
