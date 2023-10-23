class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.belongs_to :product
      t.belongs_to :user
      t.float :rating_value
      t.text :comment

      t.timestamps
    end
  end
end
