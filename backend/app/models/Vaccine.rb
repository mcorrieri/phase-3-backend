class Vaccine < ActiveRecord::Base
    has_many :statesvaccines
    has_many :states, through: :statesvaccines

    # an array of all the vaccines in ascending name order
    def self.ordered_name_list
        self.order("name ASC").pluck(:name)
    end

    def self.id_list
        self.pluck(:id)
    end

end