StudentClub = Struct.new(:name, :category, :president_id) do
  @club_templates = [
    lambda do
      (name1, category1), (name2, category2) = Static.club_activities.sample(2)
      name = "#{Static.adjs.sample} #{name1} and #{Static.adjs.sample} #{name2} Club".titleize
      category = if (category1 == category2) then category1 else 'other' end
      [name, category]
    end,
    lambda do
      name, category = Static.club_activities.sample
      organization = ["club", "society", "association"].sample
      ["The #{Static.adjs.sample} #{name} #{organization}".titleize, category]
    end
  ]

  class << self
    # [Fixnum] -> [[StudentClub], { student_id => club_id }] 
    def make_many_and_assign_membership(student_person_ids, students_per_club:, club_id_offset:)
      clubs, membership, _ = student_person_ids.to_a.shuffle.each_slice(students_per_club)
        .reduce([[], {}, club_id_offset]) do |(clubs, membership, current_club_id), member_ids|
          name, category = @club_templates.sample.call
          clubs << StudentClub[name, category, member_ids.first]
          member_ids.each { |id| membership[id] = current_club_id }
          [clubs, membership, current_club_id + 1]
        end

      [clubs, membership]
    end
  end
end
