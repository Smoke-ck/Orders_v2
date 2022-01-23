class OrdersController < ApplicationController
    before_action :authenticate_user!
  def index
    @user = current_user
    @orders = current_user.orders.order(created_at: :desc)
  end

  def history
    @orders = current_user.orders.where(active: false)
  end

  def active
    @user = current_user
    @orders = Order.where(active: true)
  end

  def show
    @order = current_user.orders.find_by id:(params[:id])
  end

  def new
    @order = Order.new
  end


  def create
    @order = current_user.orders.build(order_params)
      if @order.save
        redirect_to orders_path
      else
       render :new
      end
  end

  def destroy
    @order = current_user.orders.find_by id:(params[:id])
    @order.destroy
    redirect_to orders_path
  end

  def is_active
    @order = current_user.orders.find_by id:(params[:id])
    if @order.active == true 
      @order.update(active: false)
    else
      @order.update(active: true)
    end
    redirect_to orders_path
  end
  private

    def order_params
      params.require(:order).permit(:where, :check_out_time, :body, :active)
    end
end


