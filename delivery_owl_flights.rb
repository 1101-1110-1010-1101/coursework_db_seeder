DeliveryOwlFlight = Struct.new(:owl_id, :sender_id, :dest_coordinates, :contents_type, :departed_on, :returned_on) do
  class << self
    def get_flights(count, owl_ids, student_ids)
      date_gen = DateRangeGenerator.new.limited_to(:even_years)
      Array.new(count) do
        owl_id = owl_ids.sample
        sender_id = student_ids.sample
        dest_coordinates = "(#{Random.rand(-90.0..90.0)},#{Random.rand(-180.0..180.0)})"
        contents_type = ['1st class mail', '2nd class mail', 'parcel', 'periodical'].sample
        departed_on, returned_on = date_gen.gen('1970-1-1', 7.days)
        DeliveryOwlFlight[owl_id, sender_id, dest_coordinates, contents_type, departed_on, returned_on]
      end
    end
  end
end
