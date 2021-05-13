class State < ActiveRecord::Base
    has_many :statesvaccines
    has_many :vaccines, through: :statesvaccines

    # an array of all the states in ascending name order
    def self.ordered_list
        self.order("name ASC").pluck(:name)
    end

    def self.total_population
        self.sum(:population)
    end

    
end