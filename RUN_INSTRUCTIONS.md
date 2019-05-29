install gems:

`bundle install`

setup and seed database:

`rails db:create db:migrate db:seed`

create config/master.key with content:

`a0299bbbb41014c34b147335d1a9566b`

set env variable:

`BLOG_1_URL=http://localhost:3000`

run server:

`rails s`
