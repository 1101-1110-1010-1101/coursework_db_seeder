Creature = Struct.new(:name, :mom_classification, :discovered_on) do
  class << self
    def get_creatures(count)
      i_array = []
      if count > Static.creatures.size
        count = Static.creatures.size
      end
      Array.new(count) do
        i = Random.rand(0..Static.creatures.size)
        while i_array.any? { |v| v == i }
          i = Random.rand(0..Static.creatures.size)
        end
        name, mom_classification = Static.creatures.sample.split(':')
        discovered_on = Faker::Time.backward(100000, :all).to_s[0..-7]
        Creature[name, mom_classification, discovered_on]
      end
    end
  end
end
