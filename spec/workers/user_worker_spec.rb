
# spec/workers/user_worker_spec.rb
require 'rails_helper'
require 'csv'

RSpec.describe UserWorker, type: :worker do
  let(:csv_path) { 'spec/fixtures/test.csv' }
  let(:user_worker)  { UserWorker.new }

  describe '#perform' do
    it 'calls create_users method' do
      allow(user_worker).to receive(:create_users)
      user_worker.perform(csv_path)
      expect(user_worker).to have_received(:create_users)
    end
  end

  describe '#create_users' do
    it 'creates users from the CSV file' do
      CSV.open(csv_path, 'w') do |csv|
        csv << ['username', 'email']
        csv << ['user1', 'user1@example.com']
      end


      allow(User).to receive(:create!)
      user_worker.perform(csv_path)

      expect(User).to have_received(:create!).with(
        hash_including(
          username: 'user1',
          email: 'user1@example.com',
          password: 'aastha'
        )
      )
    end
  end
end