# frozen_string_literal: true

# Responsible for CRUD Operation for discounts Feature
class DiscountsController < ApplicationController
  before_action :set_discount, only: %i[show edit update destroy]

  before_action :authenticate_user!

  def index
    @discounts = Discount.all
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
    @discount = Discount.new
    @discountable = Discount::DISCOUNTABLE
  end

  def create
    @discount = Discount.new(discount_params)

    if @discount.save
      flash[:success] = 'discount was successfully created.'
      redirect_to @discount
    else
      render :new
    end
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    if @discount.update(discount_params)
      flash[:success] = 'discount was successfully updated.'
      redirect_to @discount
    else
      render :edit
    end
  end

  def destroy
    if @discount.destroy
      flash[:success] = 'discount was successfully destroyed.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to inventories_url
  end

  private

  def set_discount
    @discount = Discount.find(params[:id])
  end

  def discount_params
    params.require(:discount).permit(:name, :entity_id, 
    	:entity_type, :discount_field, :discount_condition, :value)
  end
end
