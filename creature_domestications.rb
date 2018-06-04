CreatureDomestication = Struct.new(:creature_id, :domesticated_by_id, :domesticated_on, :name_given) do
  @letter_adj = { 'A': %w(Amethystic Abkhaz Abstract Acid Aggressive Agog Anarchical),
    'B': %w(Baboolish), 'C': %w(Cacodemonic), 'M': %w(Male Madcap Maniacal Muscular Mysterious), 'K': %w(Khaki Kinky
    Kittenish Koranic), 'L': %w(Lithium Logy Lunatic Liberal Lucky Levelheaded Lowbred) }
  @adj = %w(Fatty Amethystic Retarded Erroneous Nerveous Introverted Pearlistic Garnetistic)
  class << self
    def get_domestications(creature_ids, people)
      creature_ids.flat_map do |creature_id|
        (0..Random.rand(0..10)).to_a.map do
          girl, girl_index = people.sample_with_index
          domesticated_by_id = girl_index + 1
          domesticated_on = if girl.death_date != nil
              Faker::Time.between(girl.birth_date + 15.years, girl.death_date, :all).to_s
            else
              Faker::Time.between(girl.birth_date + 15.years, Date.today, :all).to_s
            end
          name = Static.owl_names.sample
          name_given = "#{(@letter_adj[name.first.to_sym] || @adj).sample} #{name}"
          CreatureDomestication[creature_id, domesticated_by_id, domesticated_on, name_given]
          end
        end
      end
    end
  end
