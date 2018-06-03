SpellBook = Struct.new(:book_id, :spell_id) do
  class << self
    def get_spellbook(books_ids, spell_ids)
      spell_ids.map do |spell_id|
        book_id = books_ids.sample
        SpellBook[book_id, spell_id]
      end
    end
  end
end