StudentProfile = Struct.new(:person_id, :club_id, :study_plan_id, :dormitory_room) do
  class << self
    def make_all(plan_id_to_student_id, student_id_to_club_id)
      plan_id_to_student_id.flat_map do |plan_id, student_ids|
        student_ids.map do |student_id|
          club_id = student_id_to_club_id[student_id]
          StudentProfile[student_id, club_id, plan_id, Random.rand(1..20000)]
        end
      end
    end
  end
end
