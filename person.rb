Person = Struct.new(:full_name, :birth_date, :death_date, :personal_value, :gender, :bio) do
  class << self
    def make_many(house, birth_from:, birth_to:, count: 25)
      # If we have enough unique names, sample them
      if count < Static.names[house].values.map(&:size).min
        Static.names[house]['first_names'].sample(count)
          .zip(Static.names[house]['last_names'].sample(count))
          .map { |(first_name, gender), last_name| make_person(first_name, last_name, house, birth_from, birth_to, gender) }
      else
        generate_cross_product(house, birth_from, birth_to, count).yield_self do |entries|
          remaining_count = count - entries.size
          entries.concat(make_many(house, birth_from: birth_from, birth_to: birth_to, count: remaining_count))
        end
      end
    end

    private

    def generate_cross_product(house, birth_from, birth_to, max_count)
      name_limit = Math.sqrt(max_count).to_i
      first_names = Static.names[house]['first_names'].sample(name_limit)
      last_names = Static.names[house]['last_names'].sample(name_limit)
      first_names.flat_map do |first_name, gender|
        last_names.map { |last_name| make_person(first_name, last_name, house, birth_from, birth_to, gender) }
      end.shuffle
    end

    def make_person(first_name, last_name, house, birth_from, birth_to, gender)
      birth_date = date_between(birth_from, birth_to)
      death_date = nil
      self["#{first_name} #{last_name}", birth_date, death_date, Static.house_values[house].sample, gender, Faker::Lorem.paragraph]
    end
  end
end

