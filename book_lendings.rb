BookLending = Struct.new(:book_id, :lendee_id, :permitted_by_id, :checked_out_on, :checked_in_on) do
  class << self
    def get_lendings(books, student_ids, teachers_ids)
        books.flat_map.with_index do |book, book_id|
          ranges = []
          (0..Random.rand(0..10)).to_a.map do
            lendee_id = student_ids.sample
            var = 90.percent_chance
            checked_out_on = if var
                date_between('1970-1-1', 7.days.ago).to_s
              else
                Faker::Time.between(7.days.ago, Date.today, :all).to_s
              end
            checked_in_on = if var
              Faker::Time.between(checked_out_on, checked_out_on.to_time + 7.days, :all).to_s
            else
              nil
            end
            #ranges.any? { |range| range.includes?(checked_out_on) || range.includes?(checked_out_on) }
            #ranges << DateRange.new(checked_out_on, checked_in_on)
            if book.requires_permission
              permitted_by_id = teachers_ids.sample
            else
              permitted_by_id = nil
            end
            BookLending[book_id + 1, lendee_id, permitted_by_id, checked_out_on, checked_in_on]
          end
        end
      end
    end
  end
