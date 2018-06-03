DeliveryOwlsRepairJob = Struct.new(:owl_id, :tech_ops_manager_id, :cause, :began_on, :finished_on) do
  class << self
    def get_repair_jobs(owls, teachers_ids)
      owls.flat_map.with_index do |owl, owl_id|
        date_gen = DateRangeGenerator.new.limited_to(:odd_years)
        (0..Random.rand(0..10)).to_a.map do
          tech_ops_manager_id = teachers_ids.sample
          cause = if 20.percent_chance then 'Emergency' else 'Planned work' end
          began_on, finished_on = date_gen.gen(Date.today.to_time - owl.age.years, 7.days)
          DeliveryOwlsRepairJob[owl_id + 1, tech_ops_manager_id, cause, began_on, finished_on]
          end
        end
      end
    end
  end
