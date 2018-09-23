require 'spec_helper'
require 'rails_helper'

describe Order do

	before do
		role = Role.create!(name: 'Admin')
		@user = User.create!(name: 'example', email: 'exam@gmail.com', password: '123456',
			password_confirmation: '123456', date_of_birth: '1992-10-10 18:34:02 +05:30',
			role_id: role.id)
		@inventory = Inventory.create!(item_name: 'item1', category: 'vegetables',
			quantity_available: 10, unit: 'kg', cost_per_unit: 50)
	end

	context 'Validations' do

		before :each do
			@order = Order.new(inventory_id: @inventory.id, quantity: 3,
       user_id: @user.id, status: 'in_progress')
		end

		describe 'Validate inventory' do

			before :each do
				@order.inventory = nil
				@order.save
			end

			it "is invalid without inventory" do
				@order.errors[:inventory].should include('must exist')
			end
		end

		describe 'Validate User' do

			before :each do
				@order.user = nil
				@order.save
			end

			it "is invalid without user" do
				@order.errors[:user].should include('must exist')
			end
		end

		describe 'uniqueness validation on multiple columns' do

			before :each do
				@order.save
				@another_order = Order.new(inventory_id: @inventory.id, quantity: 3,
        user_id: @user.id, status: 'in_progress')
        @another_order.save
			end

			it "should fail with uniqueness validation" do
				@another_order.errors[:inventory].should include('Already in the cart')
			end
		end
		
		it "has inventory / user / status combined uniqueness"
	end
	
  context 'Instance Methods' do
  	it "has current_orders scope working correctly"
	  it "returns remaining_quantity hash when add_item_to_cart is called"
	  it "returns remaining_quantity hash when remove_item_from_cart is called"
  end

end
