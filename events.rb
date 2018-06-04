Event = Struct.new(:name, :started_on, :ended_on) do
  class << self
    def get_events(count, people)
      Array.new(count) do
        resource = [
          lambda { "Battle of the #{Static.places.sample}" },
          lambda { "Defeating the #{Static.creatures.sample.split(':')[0]}" },
          lambda { "#{Static.h1.sample} #{Static.h2.sample}" },
          lambda { "#{Static.h2.sample} of #{Static.h3.sample}" }
          ]
        name = resource.sample.call
        started_on = date_between('2001-1-1'.to_datetime, DateTime.now)
        ended_on = date_between(started_on + 5.minutes, started_on + 2.days)
        binding.pry if started_on > ended_on
        Event[name, started_on.to_s, ended_on.to_s]
      end
    end
  end
end
