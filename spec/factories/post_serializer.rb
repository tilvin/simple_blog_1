FactoryBot.define do
  factory :post_serializer, class: Hash do
    transient do
      post { build(:post) }
    end

    initialize_with {
      {
        id: post.id.to_s,
        type: 'post',
        attributes: {
          title: post.title,
          description: post.description,
          created_at: post.created_at,
          cover_image: nil
        }
      }
    }
  end
end
