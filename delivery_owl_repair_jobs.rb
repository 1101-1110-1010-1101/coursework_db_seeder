DeliveryOwlsRepairJob = Struct.new(:owl_id, :tech_ops_manager_id, :cause, :began_on, :finished_on) do
  class << self
    def get_repair_jobs(owls, teachers_ids)
      owls.flat_map.with_index do |owl, owl_id|
        (0..Random.rand(0..10)).to_a.map do
          tech_ops_manager_id = teachers_ids.sample
          cause = if 20.percent_chance
              'Emergency'
            else
              'Planned work'
            end
          var = 90.percent_chance
          began_on = if var
                date_between(Date.today.to_time - owl.age.years, 7.days.ago).to_s[0..-7]
              else
                Faker::Time.between(7.days.ago, Date.today, :all).to_s[0..-7]
              end
          finished_on = if var
              Faker::Time.between(began_on, began_on.to_time + 7.days, :all).to_s[0..-7]
            else
              nil
            end
          DeliveryOwlsRepairJob[owl_id + 1, tech_ops_manager_id, cause, began_on, finished_on]
          end
        end
      end
    end
  end