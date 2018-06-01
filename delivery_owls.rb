require_relative 'static'
# ------------------------- Init -----------------------------

owl_names = Static.owl_names
owl_adj = Static.owl_adj

# --------------------- Delivery owls ------------------------ 
# 1) This method returns 'count' owl names
def get_owl_names(adj, names, count)
    result = []
    for i in 0..count
      result.insert(0, adj[Random.rand(adj.size)].to_s + ' ' + names[Random.rand(names.size)].to_s)
    end
    result
end

# 2) This metod returns array of owl ages
def get_owl_ages(count)
  result = []
   for i in 0..count
      result << Random.rand(7..20)
    end
    result
end

# 2) This metod returns array of owl house_id`s
def get_owl_houses(count)
  result = []
   for i in 0..count
      result << Random.rand(1..4)
    end
    result
end

# This metod returns 'count' owls
def get_res(owl_adj, owl_names, count)
  result = get_owl_names(owl_adj, owl_names, count).zip(get_owl_ages(count), get_owl_houses(count))
end

result = get_res(owl_adj, owl_names, 5)
# ------------------------------------------------------------

def delivery_owls(data)
    data.delivery_owls = result
end