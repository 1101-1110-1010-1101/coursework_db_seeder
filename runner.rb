require 'ostruct'
require_relative 'generators'

require 'pry'

result = run_all_generators

binding.pry
