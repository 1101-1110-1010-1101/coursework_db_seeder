require 'json'
require 'faker'
require_relative 'static'

#------------- Init ---------------
nouns = Static.nouns
verbs = ['falling', 'raising', 'missing', 'finding', 'doing', 'fooling', 'accepting']
adjs = Static.adjs

data = JSON.parse(IO.read('res/name_dict.json'))
first_names = data["Gryffindor"]["first_names"].map { |val| val[0] } + data["Hufflepuff"]["first_names"].map { |val| val[0] } + data["Ravenclaw"]["first_names"].map { |val| val[0] } + data["Hufflepuff"]["first_names"].map { |val| val[0] } + data["Slytherin"]["first_names"].map { |val| val[0] }
last_names = data["Gryffindor"]["last_names"].map { |val| val } + data["Hufflepuff"]["last_names"].map { |val| val } + data["Ravenclaw"]["last_names"].map { |val| val } + data["Hufflepuff"]["last_names"].map { |val| val } + data["Slytherin"]["last_names"].map { |val| val }



# ------------ Books --------------

# 1) This metod returns 'count' book titles
def get_book_names(adjs, verbs, nouns, count)
  result = []
  for i in 0..count
    way = Random.rand(4)
    case way
      when 0 
        result.insert(0, "#{verbs[Random.rand(verbs.size)].capitalize} of the #{adjs[Random.rand(adjs.size)]} #{nouns[Random.rand(nouns.size)]}")
      when 1 
        result.insert(0, "All that you wanted to know about #{adjs[Random.rand(adjs.size)]} #{nouns[Random.rand(nouns.size)]}, but was afraid of asking")
      when 2 
        result.insert(0, "Curse of #{adjs[Random.rand(adjs.size)]} #{nouns[Random.rand(nouns.size)]}")
      when 3 
        result.insert(0, "#{nouns[Random.rand(nouns.size)].capitalize}, #{nouns[Random.rand(nouns.size)]}, and #{adjs[Random.rand(adjs.size)]} #{nouns[Random.rand(nouns.size)]}")
    end
  end
  result
end

# 2) This metod returns 'count' book authors
def get_authors(first_names, last_names, count)
  result = []
  for i in 0..count
    result << first_names.sample + ' ' + last_names.sample
  end
  result
end

# 3) This metod returns 'count' of add dates
def get_date(count)
  result = []
  for i in 0..count
    result << Faker::Time.backward(100000, :all).to_s[0..-7]
  end
  result
end

# 4) Returns array of boolean
def get_requires_permission(count)
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

# Returns array of books
def get_res(adjs, verbs, nouns, first_names, last_names, count)
  get_book_names(adjs, verbs, nouns, count).zip(get_authors(first_names, last_names, count), get_date(count), get_requires_permission(count))
end

result = get_res(adjs, verbs, nouns, first_names, last_names, 5)

# ------------------------------------------------------------

def get_books(data)
    data.books = result
end