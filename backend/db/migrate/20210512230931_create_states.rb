class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
      t.string :name
      t.integer :population
      t.string :image_url
    end
  end
end
