class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.text :order_detail
      
      t.timestamps
    end
  end
end
