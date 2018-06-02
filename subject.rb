# There aren't many subjects described in the book -- around 15 in total! --
# so we prepend additional titles like _Introduction to_ and _Higher_
# to get some variety.
# 
# There's also a distinction between core subjects (taught for the whole
# duration of the studies) and additional courses that appear on senior years. 
def subject_name(subject, year)
  # core subjects
  if subject['years'].size == 7
    case year
    when 1
      "Introduction to #{subject['name']}"
    when 2..6
      subject['name']
    else
      "Higher #{subject['name']}"
    end
  # single/two year subjects
  elsif subject['years'].size < 3
    subject['name']
  # subjects starting on the third year
  else
    case year
    when 3, 4
      "Introduction to #{subject['name']}"
    when 5, 6
      subject['name']
    else
      "Higher #{subject['name']}"
    end
  end
end

Subject = Struct.new(:name, :study_plan_id, :teacher_id) do
  # `@subject_freqs` is a hash of subject titles to the number of times
  # they occur in study plans throughout all study years (e.g. a subject
  # that's studied for 3 years will have a frequency of 3).
  #
  # `@base_teacher_count` is the sum of all subject frequencies. It is
  # used for teacher distribution, as every subject has at least one
  # dedicated teacher (the exact number is determined by count multiplier,
  # see `#teacher_count_required`.
  @subject_freqs, @base_teacher_count =
    Static.subjects.reduce([Hash.new(0), 0]) do |(freqs, teacher_count), s|
      (1..8).each do |year|
        next unless s['years'].include? year
        freqs[subject_name(s, year)] += 1
        teacher_count += 1
      end
      [freqs, teacher_count]
    end

  class << self
    # Teachers are supposed to be generated for each subject; subjects taught
    # for `n` years receive `n` teachers. The multiplier allows us to change that
    # to `kn` teachers, for when we need to generate lots of staff.
    def teacher_count_required(multiplier)
      @base_teacher_count * multiplier
    end

    # [Person] -> [StudyPlan] -> { study plan id => [Subjects] }
    def make_many(teachers, study_plans, teacher_count_multiplier: 1, study_plan_id_offset: 1)
      subject_teacher_ids, _ = @subject_freqs.reduce([{}, 0]) do |(acc, teacher_id), (s, freq)|
        acc[s] = (1..(freq * teacher_count_multiplier)).map { teacher_id += 1 }
        [acc, teacher_id]
      end

      subjects_by_plan, _ = study_plans.each_with_index.reduce([{}, Hash.new(-1)]) do |(acc, teachers_assigned), ((_, year), id)|
        plan_id = study_plan_id_offset + id
        acc[plan_id] = Static.subjects.select { |s| s['years'].include? year }.map do |s|
          name = subject_name(s, year)
          [name, plan_id, subject_teacher_ids[name][teachers_assigned[name] += 1]]
        end
        [acc, teachers_assigned]
      end

      subjects_by_plan
    end
  end
end
