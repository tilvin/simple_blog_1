install gems:

`bundle install`

copy database.yml.sample to database.yml

setup and seed database:

`bin/setup`

create config/master.key with content:

`a0299bbbb41014c34b147335d1a9566b`

set env variable:

`BLOG_1_URL=http://localhost:3000`

run server:

`rails s`
