# frozen_string_literal: true

class MenuItemsController < ApplicationController
  before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find params[:restaurant_id]
    @menu_item = @restaurant.menu_items.build
  end

  def create
    @restaurant = Restaurant.find params[:restaurant_id]
    @menu_item = @restaurant.menu_items.build(menu_item_params)
    respond_to do |format|
      if @menu_item.save
        format.html { redirect_to restaurant_path(@menu_item.restaurant_id), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @menu_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @menu_item = MenuItem.find params[:id]
  end

  def update
    @menu_item = MenuItem.find params[:id]
    respond_to do |format|
      if @menu_item.update(menu_item_params)
        format.html { redirect_to restaurant_path(@menu_item.restaurant_id), alert: "Item was successfully edited." }
        format.json { render :show, status: :created, location: @menu_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @menu_item = MenuItem.find params[:id]
    @menu_item.destroy
    respond_to do |format|
      format.html { redirect_to restaurant_path(@menu_item.restaurant_id), notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def menu_item_params
    params.require(:menu_item).permit(:title, :price, :restaurant_id)
  end
end
