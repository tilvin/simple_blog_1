# Users
['stephan', 'barbara'].each do |name|
  User.create(
    email: "#{name}@iubenda.blog.com",
    password: 'password',
    password_confirmation: 'password'
  )
end

#Posts
20.times do |i|
  post = Post.new(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph(2, false, 50),
    user: User.all.sample
  )

  post.cover_image.attach(
    io: open(Faker::LoremPixel.image(secure: false)),
    filename: "#{i}.jpg"
  )

  post.save
end
