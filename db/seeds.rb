#Users

['stephan', 'barbara'].each do |name|
  User.create(email: "#{name}@iubenda.blog.com", password: 'password', password_confirmation: 'password')
end
