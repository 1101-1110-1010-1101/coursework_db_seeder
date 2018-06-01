require 'ostruct'
require_relative 'generators'

result = OpenStruct.new.tap { |data| run_all_generators(data) }
