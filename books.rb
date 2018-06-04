Book = Struct.new(:title, :author, :added_on, :requires_permission) do
  class << self
    def get_books(count)
      Array.new(count) do
        first_names = Static.names.values.flat_map { |ns| ns['first_names'].map(&:first) }
        last_names = Static.names.values.flat_map { |ns| ns['last_names'] }
        author = "#{first_names.sample} #{last_names.sample}"
        verbs = ['falling', 'raising', 'missing', 'finding', 'doing', 'fooling', 'accepting']
        templates = [
          lambda { "#{verbs.sample} of the #{Static.adjs.sample} #{Static.nouns.sample}" },
          lambda { "All that you wanted to know about #{Static.adjs.sample} #{Static.nouns.sample}, but was afraid of asking" },
          lambda { "Curse of #{Static.adjs.sample} #{Static.nouns.sample}" },
          lambda { "#{Static.nouns.sample}, #{Static.nouns.sample}, and #{Static.adjs.sample} #{Static.nouns.sample}" }
        ]
        title = templates.sample.call.titleize
        added_on = Faker::Time.backward(100000, :all).to_s
        requires_permission = 20.percent_chance
        Book[title, author, added_on, requires_permission]
      end
    end
  end
end
