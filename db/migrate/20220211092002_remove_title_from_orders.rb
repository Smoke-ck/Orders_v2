class RemoveTitleFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :title, :string
  end
end
