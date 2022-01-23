class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :where
      t.string :chek_out_time
      t.boolean :active
      t.text :body
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
