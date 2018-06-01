require 'json'

class Static
  class << self
    def house_id(house); houses.index(house) + 1; end

    Dir["res/*.csv", "res/*.json"].each do |path|
      resource, ext = /res\/(.+)\.(csv|json)/.match(path).captures
      p "#{resource} -> #{ext}: #{path}"

      data = if ext == 'csv'
          File.read(path).split(',')
        elsif ext == 'json'
          JSON.parse(File.read(path))
        end

      define_method(resource) { data }
    end
  end
end
