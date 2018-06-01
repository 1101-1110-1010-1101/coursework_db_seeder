require_relative 'static'
require 'faker'
# ------------------------- Init -----------------------------

spicies = Static.spicies

# ----------------------- Creatures --------------------------
# 1) Returns creatures spiece names
def get_names_and_mom(spicies, count)
    result = ([''] * count).map! { |el| el = spicies.sample.split(':') }
  end
  
# 2) get_date - см. Books
def get_date(count)
    result = []
    for i in 0..count
      result << Faker::Time.backward(100000, :all).to_s[0..-7]
    end
    result
end

# 3) Returns array of creatures
def get_res(spicies, count)
    get_names_and_mom(spicies, count).map { |el| el[0] }.zip(get_names_and_mom(spicies, count).map { |el| el[1] }, get_date(count))
end

result = get_res(spicies, 5)
# ------------------------------------------------------------

def creatures(data)
    data.creatures = result
end