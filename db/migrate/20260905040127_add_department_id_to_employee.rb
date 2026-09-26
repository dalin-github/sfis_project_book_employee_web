class AddDepartmentIdToEmployee < ActiveRecord::Migration[8.1]
  def change
    add_column :employees, :department_id, :integers
  end
end
