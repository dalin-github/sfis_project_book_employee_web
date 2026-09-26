class AddAgeToEmployees < ActiveRecord::Migration[8.1]
  def change
    add_column :employees, :age, :integer
  end
end
