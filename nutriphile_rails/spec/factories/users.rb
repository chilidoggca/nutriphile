FactoryBot.define do
  factory :user do
    email {Faker::Name.first_name.downcase + "." + Faker::Name.last_name.downcase + "@example.com"}
    password {"supersecret"}
  end
end
