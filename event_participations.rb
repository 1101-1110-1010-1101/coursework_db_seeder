EventParticipation = Struct.new(:event_id, :student_profile_id, :is_positive, :score, :date) do
  class << self
    def get_participations(profile_id_to_person, events)
      events.flat_map.with_index do |event, event_index|
        participants = profile_id_to_person.entries
          .select { |_, g| g.birth_date < event.started_on && (g.death_date.nil? || g.death_date >= event.ended_on) }
          .sample(Random.rand(1..15))
        participants.map do |profile_id, _|
          is_positive = 50.percent_chance
          score = Random.rand(1..25)
          participation_date = date_between(event.started_on, event.ended_on)
          EventParticipation[event_index + 1, profile_id, is_positive, score, participation_date]
        end
      end
    end
  end
end




