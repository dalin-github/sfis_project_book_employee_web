class CreateEmployees < ActiveRecord::Migration[8.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.integer :ages
      t.string :role
      t.string :gender
      t.string :hobbies

      t.timestamps
    end
  end
end
