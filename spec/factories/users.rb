FactoryBot.define do
  factory :user do
    email
    password { "password"}
    password_confirmation { "password" }
  end
end
