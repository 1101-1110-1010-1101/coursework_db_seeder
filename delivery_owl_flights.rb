DeliveryOwlFlight = Struct.new(:owl_id, :sender_id, :dest_coordinates, :contents_type, :departed_on, :returned_on) do
  class << self
    def get_flights(count, owl_ids, student_ids)
      Array.new(count) do
        owl_id = owl_ids.sample
        sender_id = student_ids.sample
        dest_coordinates = "(#{Random.rand(-90.0..90.0)},#{Random.rand(-180.0..180.0)})"
        contents_type = ['1st class mail', '2nd class mail', 'parcel', 'periodical'].sample
        var = 90.percent_chance
        departed_on = if var
            date_between('1970-1-1', Date.today).to_s[0..-7]
          else
            Faker::Time.between(7.days.ago, Date.today, :all).to_s[0..-7]
          end
        returned_on = if var
            Faker::Time.between(departed_on, departed_on.to_time + 7.days, :all).to_s[0..-7]
          else
            nil
          end
        DeliveryOwlFlight[owl_id, sender_id, dest_coordinates, contents_type, departed_on, returned_on]
      end
    end
  end
end

        















# ------------------ Delivery owl flights --------------------
# 1) Return array of owl id`s, where n - owl amount
def get_owl_ids(count)
  result = []
  for i in 0..count
    result << i + 1
  end
  result
end

# 2) Return array of senders id`s
def get_senders_id(people, owl_ids, owls)
  result = []
  for i in owl_ids
    case owls[i][2] 
    when 1
      result << people.from_G.sample
    when 2 
      result << people.from_H.sample
    when 3
      result << people.from_R.sample
    when 4
      result << people.from_S.sample
    end
  end
  result
end

# 3) Return array of destination coordinates
def get_coors(count)
  result = []
  for i in 0..count
    result << "(#{Random.rand(-90.0..90.0)},#{Random.rand(-180.0..180.0)})"
  end
  result
end

# 4) Return array of contents types
def get_contents(contents, count)
  result = []
  for i in 0..count
    result << contents.sample
  end
  result
end

# 5) Returns array of flight times
def get_flight_times(count)
  started = get_date(count)
  ended = []
  started.each do | s_time |
    ended << Faker::Time.between(s_time, s_time.to_time + 7.days, :all).to_s[0..-7]
  end
  x = count/10
  for i in 0..x
    y = Random.rand(started.size)
    started[y] = Faker::Time.between(7.days.ago, Date.today, :all).to_s[0..-7]
  ended[y] = 'null'
  end
  started.zip(ended)
end