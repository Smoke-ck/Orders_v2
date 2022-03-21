# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_all_restaurant, only: %i[new create]
  before_action :load_order, only: %i[actived destroy]

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
    @order = current_user.orders.includes(:restaurant).find_by id: params[:id]
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

  private

  def order_params
    params.require(:order).permit(:check_out, :body, :active, :restaurant_id)
  end

  def load_all_restaurant
    @restaurants = Restaurant.all
  end

  def load_order
    @order = current_user.orders.find_by id: params[:id]
  end
end
