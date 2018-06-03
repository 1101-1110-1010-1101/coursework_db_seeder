CreatureBook = Struct.new(:book_id, :creature_id) do
  class << self
    def get_creaturebook(books_ids, creature_ids)
      creature_ids.map do |creature_id|
        book_id = books_ids.sample
        CreatureBook[book_id, creature_id]
      end
    end
  end
end