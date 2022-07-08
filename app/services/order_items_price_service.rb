# frozen_string_literal: true

class OrderItemsPriceService < ApplicationService
  parameters :order_items

  def call
    price = {}
    order_items.each do |key, _value|
      order_items[key].each do |x|
        items_price = x.menu_item.price.to_i * x.count
        if price.key?(key)
          price[key] += items_price
        else
          price[key] = items_price
        end
      end
    end
    price
  end
end
