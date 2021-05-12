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
end