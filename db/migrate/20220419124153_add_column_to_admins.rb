class AddColumnToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :name, :string
    add_column :admins, :surname, :string
    add_column :admins, :phone, :string
  end
end
