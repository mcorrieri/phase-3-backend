class Statevaccine < ActiveRecord::Base
    belongs_to :state
    belongs_to :vaccine

    # provides the default date to go into the "from date" on the search
    def self.start_date
        self.first.allocation_date
    end

    # provides the default date to go into the "to date" on the search
    def self.end_date
        self.last.allocation_date
    end

    def self.vaccine_state(state_arr, vaccine_arr, from_date, to_date)
        
        # look for all the records that match the state(s), return values to a variable
        self_arr = self.where(state_id: state_arr)
        
        # look for all the records that match the vaccine(s), return values to a variable
        self_state_arr = self_arr.where(vaccine_id: vaccine_arr)

        # look for all the records in the date range, return values to a varaible
        self_state_vaccine_arr = self_state_arr.where(:allocation_date => from_date..to_date)

        #use map to create a new array of arrays for the priamry query
        output_array = []
        self_state_vaccine_arr.map do |statevaccine_instance|
            output_array = output_array + 
                            [statevaccine_instance.state_id,
                            statevaccine_instance.vaccine_id,
                            statevaccine_instance.allocation_date,
                            statevaccine_instance.first_dose_allocation,
                            statevaccine_instance.second_dose_allocation]
        end

        output_array

    end

    def self.national_vaccinated
        self.sum(:first_dose_allocation)
    end 

    def self.national_percentage_vaccinated
        percentage_vaccinated = Float(Float(self.national_vaccinated) / Float(State.total_population)) * 100
        percentage_vaccinated
    end

    #vaccine data for landing national data page
    def self.national_by_vaccine
        self_nat_vac_arr = self.group('vaccine_id')
                                .pluck("vaccine_id, sum(first_dose_allocation)")
        
        self_nat_vac_arr
    end

    # data for landing national data page chart
    def self.national_chart

        #group and order table by allocation, then pull out allocation_date as well as summ the first_dose_allocation
        self_nat_arr = self.group('allocation_date')
                            .order('allocation_date DESC')
                            .pluck("allocation_date, sum(first_dose_allocation)")

        # symbolize_keys is probably not needed
        self_nat_arr.to_h.symbolize_keys
        
    end

    def self.national_data
        start_date = self.start_date
        nat_by_vac = self.national_by_vaccine
        moderna = nat_by_vac[0][1]
        pfizer = nat_by_vac[1][1]
        janssen = nat_by_vac[2][1]
        total_vaccine = self.national_vaccinated
        total_vaccine_percent = self.national_percentage_vaccinated
        nat_hash = { 
          lastDate: start_date,
          moderna: moderna,
          pfizer: pfizer, 
          janssen: janssen,
          totalVaccines: total_vaccine,
          percentVacc: total_vaccine_percent }
        nat_array = [nat_hash]
    end
end