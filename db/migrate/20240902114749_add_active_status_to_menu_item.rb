class AddActiveStatusToMenuItem < ActiveRecord::Migration[7.0]
  def change
    add_column :menu_items, :active, :boolean, default: true
  end
end
