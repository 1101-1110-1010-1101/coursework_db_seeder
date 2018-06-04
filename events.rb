Event = Struct.new(:name, :started_on, :ended_on) do
  class << self
    def get_events(count)
      Array.new(count) do
        resource = [
          lambda { "Battle of the #{Static.places.sample}" },
          lambda { "Defeating the #{Static.creatures.sample.split(':')[0]}" },
          lambda { "#{Static.h1.sample} #{Static.h2.sample}" },
          lambda { "#{Static.h2.sample} of #{Static.h3.sample}" }
          ]
        name = resource.sample.call
        started_on = Faker::Time.between('1970-1-1'.to_datetime, DateTime.now, :day) - 1.hour
        ended_on = Faker::Time.between(started_on, started_on + 2.days, :evening)
        Event[name, started_on.to_s, ended_on.to_s]
      end
    end
  end
end
