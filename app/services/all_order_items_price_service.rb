# frozen_string_literal: true

class AllOrderItemsPriceService < ApplicationService
  parameters :order_items, :menu_items

  def call
    all_price = 0
    items = {}
    order_items.each do |key, value|
      menu_items.each do |item|
        if item.id == key
          items[item.title] = value
          all_price += item.price.to_i * value
        end
      end
    end
    items["All price"] = all_price
    items
  end
end
