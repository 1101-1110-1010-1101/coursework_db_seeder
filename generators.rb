require_relative 'static'

def run_all_generators(data)
  # The first generator defined should be run first,
  # so we reverse the method list (which has the last defined one first).
  Generators.methods(false).reverse.each { |g| Generators.send(g, data) }
end

module Generators
  class << self
    def houses(data)
      data.houses = [
        ['Gryffindor', 1, '{"courage", "bravery"}'],
        ['Hufflepuff', 2, '{"hard work", "patience", "justice", "loyalty"}'],
        ['Ravenclaw', 3, '{"intelligence", "creativity", "wit"}'],
        ['Slytherin', 4, '{"ambition", "cunning", "leadership", "resourcefulness"}']
      ]
    end

    def people_deans(data)
      (data.teachers ||= []) << [
        ['Minerva McGonagall', '1931-10-04', nil, 'courage', 'female', "Gryffindor's Dean"],
        ['Pomona Sprout', '1941-05-15', nil, 'hard work', 'female', "Hufflepuff's Dean"],
        ['Filius Flitwick', '1958-10-17', nil, 'wit', 'male', "Ravenclaw's Dean"],
        ['Severus Snape', '1960-01-06', nil, 'leadership', 'male', "Slytherin's Dean"]
      ]
    end
  end
end
