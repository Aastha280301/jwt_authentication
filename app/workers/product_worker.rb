require 'csv'

class ProductWorker
  include Sidekiq::Worker

  attr_accessor :csv_path

  def perform(csv_path)
    @csv_path = csv_path
    create_products
  end

  def create_products
    CSV.foreach(csv_path, headers: true) do |product|
      Product.create!(
        products_name: product['products_name'],
        price: product['price'],
        user_id: 27,
        order_id: 17
      )
    end
  end
  
end