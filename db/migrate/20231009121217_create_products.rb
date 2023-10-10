class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.belongs_to :user
      t.string :products_name
      t.float :price
      t.belongs_to :order
      
      t.timestamps
    end
  end
end
