# frozen_string_literal: true

class OrdersController < ApplicationController
  include OrdersOrderItems
  before_action :authenticate_user!
  before_action :load_all_restaurant, only: %i[new create]
  before_action :load_order, only: %i[actived destroy show paid_users]
  before_action :load_order_restaurant, only: %i[show owner_show]
  before_action :redirect_to_show, only: :owner_show

  def index
    @orders = current_user.orders.includes(:restaurant).order(created_at: :desc)
  end

  def history
    @orders = current_user.orders.includes(:restaurant).where(active: false)
  end

  def active
    @user = current_user
    @orders = Order.where(active: true).includes(:restaurant)
  end

  def show
    @order_items = current_user.order_items.where(order_id: params[:id])
    @order_item = @order.order_items.build
    @menu_items = @order.restaurant.menu_items.where(active: true)
  end

  def owner_show
    @order_items = @order.order_items.group_by(&:user_id)
    @price = OrderItemsPriceService.call(@order_items)

    all_order_items = @order.order_items.group(:menu_item_id).sum(:count)
    @items = AllOrderItemsPriceService.call(all_order_items, @order.restaurant.menu_items)
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to order_path(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_path, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def actived
    if @order.active == true
      @order.update(active: false)
    else
      @order.update(active: true)
    end
    redirect_to orders_path
  end

  def paid_users
    if @order.paid_users_id.include?(params[:format])
      @order.paid_users_id.delete(params[:format])
    else
      @order.paid_users_id << params[:format]
    end
    @order.save
    redirect_to owner_show_order_path(@order.id)
  end

  private

  def order_params
    params.require(:order).permit(:check_out, :body, :active, :restaurant_id)
  end

  def load_all_restaurant
    @restaurants = Restaurant.all
  end

  def load_order
    @order = Order.find_by id: params[:id]
  end

  def load_order_restaurant
    @order = Order.includes(restaurant: :menu_items).find_by(id: params[:id])
  end

  def redirect_to_show
    redirect_to action: :show if current_user.id != @order.user_id
  end
end
