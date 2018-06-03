ClassroomBooking = Struct.new(:subject_id, :student_club_id, :room_number, :week_day, :occupied_from, :occupied_to) do
  class << self
    # For our convenience, let's assume that
    # regular classes (45+15 mins) are held Mon-Fri, clubs are on Sats.
    def make_all(plan_id_to_subject_ids, club_ids)
      week_days = %w(Monday Tuesday Wednesday Thursday Friday Saturday)
      times_of_day = [%w(9:00 10:00), %w(10:30 11:30), %w(13:00 14:00)]

      week_days_occupation = week_days.map { |d| [d, 0] }.to_h

      plan_id_to_subject_ids.flat_map do |plan_id, subject_ids|
        subject_ids.each_slice(3).flat_map.with_index do |subject_ids, week_day_id|
          subject_ids.map.with_index do |subject_id, time_of_day|
            room_number = ((20 * plan_id) + subject_id)
            occupied_from, occupied_to = times_of_day[time_of_day]
            ClassroomBooking[subject_id, nil, room_number, week_days[week_day_id], occupied_from, occupied_to]
          end
        end
      end.concat(club_ids.map do |club_id|
        room_number = 100 + club_id / 3
        occupied_from, occupied_to = times_of_day[club_id % 3]
        ClassroomBooking[nil, club_id, room_number, week_days[-1], occupied_from, occupied_to]
      end)
    end
  end
end
