class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end

    add_column :users, :role_id, :integer, index: true

    Role::ROLES_ARRAY.each do |role|
      Role.create!(name: role)
    end
  end
end
