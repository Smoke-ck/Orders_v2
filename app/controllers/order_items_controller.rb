# frozen_string_literal: true

class OrderItemsController < ApplicationController
  before_action :load_order, only: %i[new create]
  before_action :load_order_item, only: %i[edit update destroy]
  before_action :load_restaurant, only: %i[edit update]

  def new
    @order_item = @order.order_items.build
  end

  def create
    @order_item = @order.order_items.build(order_items_params)
    respond_to do |format|
      if @order_item.save
        format.turbo_stream { flash.now[:notice] = "Item was successfully created." }
        format.html { redirect_to order_path(@order_item.order_id) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @order_item.update(order_items_params)
        format.turbo_stream { flash.now[:notice] = "Item was successfully update." }
        format.html { redirect_to order_path(@order_item.order_id) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order_item.destroy
    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Item was successfully deleted." }
      format.html {  redirect_to order_path(@order_item.order_id) }
    end
  end

  private

  def order_items_params
    params[:order_item].merge!(user_id: current_user.id)
    params.require(:order_item).permit(:count, :menu_item_id, :user_id)
  end

  def load_order
    @order = Order.includes(restaurant: :menu_items).find params[:order_id]
  end

  def load_order_item
    @order_item = OrderItem.find params[:id]
  end

  def load_restaurant
    @order_item = OrderItem.find params[:id]
    @order = @order_item.order
  end
end
