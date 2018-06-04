Creature = Struct.new(:generic_name, :mom_classification, :discovered_on) do
  class << self
    def get_creatures(count)
      i_array = []
      count = if count > Static.creatures.size
        Static.creatures.size - 1
      end
      Array.new(count) do
        i = Random.rand(0..Static.creatures.size - 1)
        while i_array.any? { |v| v == i }
          i = Random.rand(0..Static.creatures.size - 1)
        end
        i_array << i
        name, mom_classification = Static.creatures[i].split(':')
        discovered_on = Faker::Time.backward(100000, :all).to_s
        Creature[name, mom_classification, discovered_on]
      end
    end
  end
end
