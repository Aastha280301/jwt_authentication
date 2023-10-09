FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { 'astha28@gmail' }
    password { '123456' } 

  end
end
