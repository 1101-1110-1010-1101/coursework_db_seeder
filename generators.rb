%w(
  static utils
  person house study_plan subject
  delivery_owls
).each { |s| require_relative s } 

def run_all_generators
  # The first generator defined should be run first,
  # so we reverse the method list (which has the last defined one first).
  generators = Generators.methods(false).reverse
  
  data = OpenStruct.new({
    students: [], study_plans: [], subjects: [],
    delivery_owls: [],
    current_house: OpenStruct.new
  })

  Static.houses.each { |house| generators.each { |g| Generators.send(g, data, house) } }
end

STUDENTS_PER_HOUSE = 100
PLANS_PER_YEAR = 4
STUDENTS_PER_CLUB = 8
OWLS_PER_HOUSE = 10

module Generators
  class << self
    def houses(data, _house)
      data.houses ||= [
        House['Gryffindor', 1, '{"courage", "bravery"}'],
        House['Hufflepuff', 2, '{"hard work", "patience", "justice", "loyalty"}'],
        House['Ravenclaw', 3, '{"intelligence", "creativity", "wit"}'],
        House['Slytherin', 4, '{"ambition", "cunning", "leadership", "resourcefulness"}']
      ]
    end

    def people_deans(data, _house)
      data.teachers ||= [
        Person['Minerva McGonagall', '1931-10-04'.to_datetime, nil, 'courage', 'female', "Gryffindor's Dean"],
        Person['Pomona Sprout', '1941-05-15'.to_datetime, nil, 'hard work', 'female', "Hufflepuff's Dean"],
        Person['Filius Flitwick', '1958-10-17'.to_datetime, nil, 'wit', 'male', "Ravenclaw's Dean"],
        Person['Severus Snape', '1960-01-06'.to_datetime, nil, 'leadership', 'male', "Slytherin's Dean"]
      ]
    end

    def subjects_study_plans(data, house)
      students = Person.make_many house,
        birth_from: '2001-1-1', birth_to: '2007-12-31', count: STUDENTS_PER_HOUSE
      study_plans, plan_id_to_student_id = StudyPlan.make_many house, students,
        max_plans_per_year: PLANS_PER_YEAR, study_plan_id_offset: (data.study_plans&.size || 0) + 1
      teachers = Person.make_many house,
        birth_from: '1950-1-1', birth_to: '1990-1-1', count: Subject.teacher_count_required(PLANS_PER_YEAR)
      plan_id_to_subject_id = Subject.make_many teachers, study_plans,
        teacher_count_multiplier: PLANS_PER_YEAR, study_plan_id_offset: (data.study_plans&.size || 0) + 1

      first_student_id = data.students.size + 1
      student_ids_plans = study_plans.transform_values { |v| v.map { last_student_id += 1 } }

      data.current_house.student_ids = first_student_id..(first_student_id + students.size)
      data.students += students
      data.teachers += teachers

      #student_clubs, club_membership = StudentClub.make_many_and_assign_membership students,
      #  students_per_club: STUDENTS_PER_CLUB

      #(data.study_plans ||= []).concat study_plans
      #(data.subjects ||= []).concat plan_id_to_subject_id.values.flatten(1)
    end

    def delivery_owls(data, house)
      first_owl_id = data.delivery_owls.size + 1
      owls = DeliveryOwl.del_owls(Static.house_id(house), OWLS_PER_HOUSE)

      data.delivery_owls += owls
      data.current_house.owl_ids = first_owl_id..(first_owl_id + owls.size)
    end
  end
end
