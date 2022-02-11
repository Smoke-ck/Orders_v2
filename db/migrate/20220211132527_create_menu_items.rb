class CreateMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items do |t|
      t.string :title
      t.decimal :price, precision: 5, scale: 2
      t.belongs_to :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
