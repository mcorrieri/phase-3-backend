class CreateStatevaccines < ActiveRecord::Migration[5.2]
  def change
    create_table :statevaccines do |t|
      t.string :allocation_date
      t.integer :first_dose_allocation
      t.integer :second_dose_allocation
      t.integer :state_id
      t.integer :vaccine_id
    end
  end
end
