# frozen_string_literal: true

# Responsible for CRUD operations for orders
class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = if params[:user_id].blank?
                Order.all
              else
                Order.where(user_id: params[:user_id])
              end
  end

  def add_to_cart
    item_hash = Order.add_item_to_cart(params[:item_name], params[:quantity],
                                       current_user)

    render json: { item: item_hash }
  end

  def remove_from_cart
    item_hash = Order.remove_item_from_cart(params[:item_name],
                                            params[:quantity], current_user)

    render json: { item: item_hash }
  end
end
