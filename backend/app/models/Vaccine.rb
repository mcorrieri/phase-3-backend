class Vaccine < ActiveRecord::Base
    has_many :statesvaccines
    has_many :states, through: :statesvaccines

    # an array of all the vaccines in ascending name order
    def self.ordered_list
        self.order("name ASC").pluck(:name)
    end

end