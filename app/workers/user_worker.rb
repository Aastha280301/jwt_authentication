require 'csv'

class UserWorker
  include Sidekiq::Worker

  def perform(csv_path)
    CSV.foreach(csv_path, headers: true) do |user|
      User.create!(
        username: user[1],
        email: user[2],
       password: "aastha",
      )
    end
  end
end
