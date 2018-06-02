Creature = Struct.new(:name, :mom_classification, :discovered_on) do
  class << self
    def get_creatures(count)
      Array.new(count) do
      name, mom_classification = Static.creatures.sample.split(':')
      discovered_on = Faker::Time.backward(100000, :all).to_s[0..-7]
      Creature[name, mom_classification, discovered_on]
      end
    end
  end
end