namespace :seed do

  desc 'Import example Data'
  task inventories: :environment do

  	admin_role = Role.create!(name: Role::ADMIN)
  	shopper_role = Role.create!(name: Role::SHOPPER)

  	admin_user = User.create!(name: 'Admin', email: '12345@example.com',
  	 date_of_birth: '1992-10-10 06:59:02 +05:30', password: '12345678',
  	 password_confirmation: '12345678', role_id: admin_role.id)

  	shopper = User.create!(name: 'Shopper', email: '123456@example.com',
  	 date_of_birth: '1992-10-10 06:59:02 +05:30', password: '12345678',
  	 password_confirmation: '12345678', role_id: shopper_role.id)

  	Inventories_array = [{ item_name: 'Carrot', category: 'vegetables',
  		quantity_available: 10, unit: 'kg', cost_per_unit: 25},
  		{ item_name: 'Urud dhal', category: 'grocery',
  		quantity_available: 80, unit: 'kg', cost_per_unit: 50},
  		{ item_name: 'Ponni Rice', category: 'grocery',
  		quantity_available: 100, unit: 'kg', cost_per_unit: 60},
  		{ item_name: 'Ground nut oil', category: 'Oil',
  		quantity_available: 50, unit: 'kg', cost_per_unit: 70},
  		{ item_name: 'Lizol', category: 'toileteries',
  		quantity_available: 10, unit: 'l', cost_per_unit: 70},
  		{ item_name: 'Apple', category: 'fruits',
  		quantity_available: 10, unit: 'kg', cost_per_unit: 25}

  	]

  	Inventories_array.each do |inventory|
  		Inventory.create!(inventory)
  	end
  end
end