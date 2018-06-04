BookLending = Struct.new(:book_id, :lendee_id, :permitted_by_id, :checked_out_on, :checked_in_on) do
  class << self
    def get_lendings(books, student_ids, teachers_ids)
        books.flat_map.with_index do |book, book_id|
          date_gen = DateRangeGenerator.new
          (0..Random.rand(0..10)).map do
            lendee_id = student_ids.sample
            checked_out_on, checked_in_on = date_gen.gen('1970-1-1', 7.days)
            permitted_by_id = teachers_ids.sample if book.requires_permission
            BookLending[book_id + 1, lendee_id, permitted_by_id, checked_out_on.to_s, checked_in_on&.to_s]
          end
        end
      end
    end
  end
