ExamResult = Struct.new(:subject_id, :profile_id, :attended_on, :mark) do
  # How likely any given student is to pass an exam
  @exam_passabilities = [40] + [75, 75] + 8.times.map { 90 } + 4.times.map { 100 }

  class << self
    # Returns a hash of { plan_id => [[Student, profile_id]] }
    def plan_id_to_student_info(students, plan_id_to_student_id, student_id_to_profile_id, student_id_offset:)
      student_id_to_plan_id = plan_id_to_student_id.reduce({}) do |acc, (plan_id, student_ids)|
        student_ids.each { |student_id| acc[student_id] = plan_id }
        acc
      end
      students.each_with_index.reduce({}) do |acc, (student, i)|
        student_id = student_id_offset + i
        plan_id = student_id_to_plan_id[student_id]
        profile_id = student_id_to_profile_id[student_id]
        (acc[plan_id] ||= []) << [student, profile_id]
        acc
      end
    end

    def make_all(plan_id_to_student_info, plan_id_to_subject_ids)
      plan_id_to_student_info.flat_map do |plan_id, student_infos|
        exam_date = '2018-5-15 12:30'.to_datetime
        plan_id_to_subject_ids[plan_id].flat_map do |subject_id|
          passability = @exam_passabilities.sample
          exam_date += Random.rand(2..4).days
          student_infos.map do |student, profile_id|
            passed = if passability.percent_chance then 'passed' else 'not passed' end
            ExamResult[subject_id, profile_id, exam_date, passed]
          end
        end
      end
    end
  end
end
