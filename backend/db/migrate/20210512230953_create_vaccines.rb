class CreateVaccines < ActiveRecord::Migration[5.2]
  def change
    create_table :vaccines do |t|
      t.string :name
      t.integer :doses
    end
  end
end
