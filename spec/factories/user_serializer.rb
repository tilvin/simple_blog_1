FactoryBot.define do
  factory :user_serializer, class: Hash do
    transient do
      user { build(:user) }
    end

    initialize_with {
      {
        id: user.id.to_s,
        type: 'user',
        attributes: {
          email: user.email,
          posts_count: user.posts_count,
          token: JwtProcessor.encode(user.email)
        }
      }
    }
  end
end
