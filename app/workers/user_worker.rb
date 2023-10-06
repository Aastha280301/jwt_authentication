require 'csv'

class UserWorker
  include Sidekiq::Worker

  attr_accessor :csv_path

  def perform(csv_path)
    @csv_path = csv_path
    create_users  
  end

  def create_users
    CSV.foreach(csv_path, headers: true) do |user|
    User.create!(
      username: user['username'],
      email: user['email'],
      password: "aastha",
    )
    end
  end
end