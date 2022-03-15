# frozen_string_literal: true

module OrdersOrderItems
  extend ActiveSupport::Concern

  included do
    def all_order_items_count_price(order_items, menu_items)
      all_price = 0
      @items = {}
      order_items.each do |key, value|
        menu_items.each do |item|
          if item.id == key
            @items[item.title] = value
            all_price += item.price.to_i * value
          end
        end
      end
      @items["All price"] = all_price
    end
  end

  def order_items_price(order_items)
    @price = {}
    order_items.each do |key, _value|
      order_items[key].each do |x|
        items_price = x.menu_item.price.to_i * x.count
        if @price.key?(key)
          @price[key] += items_price
        else
          @price[key] = items_price
        end
      end
    end
  end
end
