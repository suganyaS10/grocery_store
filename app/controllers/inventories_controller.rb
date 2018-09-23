# frozen_string_literal: true

# Responsible for CRUD operations for Inventories
class InventoriesController < ApplicationController
  before_action :set_inventory, only: %i[show edit update destroy]

  def index
    @inventories = Inventory.all
    @user_role = current_user.role.name if current_user
  end

  def show; end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)

    if @inventory.save
      flash[:success] = 'Inventory was successfully created.'
      redirect_to @inventory
    else
      render :new
    end
  end

  def edit; end

  def update
    if @inventory.update(inventory_params)
      flash[:success] = 'Inventory was successfully updated.'
      redirect_to @inventory
    else
      render :edit
    end
  end

  def destroy
    if @inventory.destroy
      flash[:success] = 'Inventory was successfully destroyed.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to inventories_url
  end

  def stock_report
    @inventories = Inventory.generate_stock_report

  end

  private

  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  def inventory_params
    params.require(:inventory).permit(:item_name, :category,
    :quantity_available, :unit, :cost_per_unit)
  end
end
