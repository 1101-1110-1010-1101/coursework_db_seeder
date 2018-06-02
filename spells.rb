Spell = Struct.new(:counterspell_id, :creator_id, :name, :description, :type, :is_forbidden) do
  class << self
    def get_spells(count, teachers_id_range)
      Array.new(count) do
        counterspell_id = Random.rand(1..count) if 10.percent_chance
        creator_id = teachers_id_range.to_a.sample
        name = "#{Static.latin_vocabulary_list.sample} #{Static.latin_vocabulary_list.sample}"
        description = ''
        type = ['Conjuration', 'Charm', 'Healing Spell' ,'Curse' ,'Transfiguration'].sample
        is_forbidden = 20.percent_chance
        Spell[counterspell_id, creator_id, name, description, type, is_forbidden]
      end
    end
  end
end