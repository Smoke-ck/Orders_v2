class AddPaidToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :paid_users_id, :text, array:true, default: []
  end
end
