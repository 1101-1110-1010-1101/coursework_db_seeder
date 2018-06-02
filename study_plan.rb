StudyPlan = Struct.new(:house_id, :academic_year) do
  class << self
    # String -> [Person] -> Fixnum -> Fixnum -> [[StudyPlan], { study plan id => person ids }]
    def make_many(house, students, max_plans_per_year: 2, study_plan_id_offset: 1)
      students_by_years(students).reduce({ plans: [], grouped: {} }) do |acc, (year, studs)|
        plans_this_year = [studs.size, max_plans_per_year].min
        acc[:plans].concat((1..plans_this_year).map { [Static.house_id(house), year] })
        studs.each_with_index do |s, i|
          plan_id = study_plan_id_offset + (i % plans_this_year)
          (acc[:grouped][plan_id] ||= []) << s
        end
        study_plan_id_offset += plans_this_year
        acc
      end.values
    end
  
    private

    # [Person] -> { Fixnum => [Person] }
    def students_by_years(students)
      students.reduce({}) do |acc, s|
        study_year = ('2018-1-1'.to_datetime.year - s.birth_date.year) - 10
        (acc[study_year] ||= []) << s
        acc
      end.sort.reverse.to_h
    end
  end
end
