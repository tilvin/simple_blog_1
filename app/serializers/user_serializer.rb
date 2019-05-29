class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :posts_count

  attribute :token do |object|
    JwtProcessor.encode(object.email)
  end
end
