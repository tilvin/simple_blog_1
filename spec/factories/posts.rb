FactoryBot.define do
  factory :post do
    user
    title { "MyString" }
    description { "MyText" }
  end
end
