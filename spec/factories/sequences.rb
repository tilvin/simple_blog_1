FactoryBot.define do
  sequence(:id) { |n| n }
  sequence(:title) { |n| "Post title #{n}" }
  sequence(:description) { |n| "Post description #{n}" }
  sequence(:url) { |n| "http://test.com/#{n}" }
  sequence(:email) { |n| "user#{n}@factory.com" }
end
