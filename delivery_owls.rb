DeliveryOwl = Struct.new(:name, :age, :house_id) do
  class << self
    # This metod returns 'count' owls
    def del_owls(house_id, count)
      Array.new(count) do 
        name = "#{Static.owl_adj.sample} #{Static.owl_names.sample}"
        age = Random.rand(7..20)
        DeliveryOwl[name, age, house_id] 
      end
    end
  end
end