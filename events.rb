Event = Struct.new(:name, :started, :ended) do
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
        started = date_between('1970-1-1', Date.today).to_s[0..-7]
        ended = Faker::Time.between(started, started.to_time + 2.days, :all).to_s[0..-7]
        Event[name, started, ended]
        end
      end
    end
  end