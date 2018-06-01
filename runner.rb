require 'ostruct'
require_relative 'generators'

require 'pry'

result = OpenStruct.new.tap { |data| run_all_generators(data) }

binding.pry
