require_relative 'static'
# -------------------------- Init ----------------------------

dict = Static.latin_vocabulary_list
n = Static.teachers.size    # FIXME 

# ------------------------- Spells ---------------------------

# 1) Return 'count' spell names
def get_spell_names(dict, count)
    result = []
    for i in 0..count - 1
      result.insert(0, dict[Random.rand(dict.size)].to_s + ' ' + dict[Random.rand(dict.size)].to_s)
    end
    result
  end
  
  # 2) Return counterspells array
  def get_counterspell_id(count)
    result = ['null'] * count
    coef = count * 0.1
    if coef < 1
      coef = 1
    end
    for i in 0..coef
      result[Random.rand(result.size)] = Random.rand(1..result.size)
    end
    result
  end
  
  # 3) Return creators array, n - people amount
  def get_creators(count, n)
    result = []
    for i in 0..count
      result[i] = Random.rand(1..n)
    end
    result
  end
  
  # 4) Return type array
  def get_types(count)
    types = ['Conjuration', 'Charm', 'Healing Spell' ,'Curse' ,'Transfiguration']
    result = []
    for i in 0..count - 1
      result << types.sample
    end
    result
  end
  
  # 5) Returns array of boolean
  def get_forbidden_state(count)
    coef = count * 0.1
    result = [false] * (count + 1)
    if coef < 1
      coef = 1
    end
    for i in 0..coef
      result[Random.rand(result.size)] = true
    end
    result
  end
  
  def get_res(dict, n, count)
    get_spell_names(dict, count).zip(get_types(count), get_creators(n, count), get_counterspell_id(count), get_forbidden_state(count))
  end
  
  result = get_res(dict, n, 5)
  # ------------------------------------------------------------

  def spells(data)
    data.spells = result
  end
  