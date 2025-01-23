class CreateRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :roles do |t|
      t.string :role_name
      t.string :description
      
      t.timestamps
    end
  end
end
