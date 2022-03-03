# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_restaurant, only: %i[edit update destroy]

  def index
    @restaurants = Restaurant.all.includes(:orders)
    new
  end

  def show
    @restaurant = Restaurant.includes(:menu_items).find params[:id]
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit; end

  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to restaurants_path, alert: "Restaurant was successfully edited." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to restaurants_path, notice: "Restaurant was successfully created." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_path, notice: "Restaurant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:title)
  end

  def load_restaurant
    @restaurant = Restaurant.find params[:id]
  end
end
