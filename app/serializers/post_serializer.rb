class PostSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :description, :created_at

  attribute :cover_image do |object|
    if object.cover_image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.cover_image, host: "#{ENV['BLOG_1_URL']}")
    end
  end
end
