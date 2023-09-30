# README

This is the code for my own personal site where I post blogs and stuff. Over time, I want to expand this to have a variety of different topics and features. Pretty barebones for right now. We only have

1. Viewing multiple blogs
2. Rendering blogs written in markdown into HTML

I expect most of the content here to be backend focused, although I may post some frontend designs from time to time.

How to run:
  1. Copy `env_template` to `.env`
  2. Fill `.env` fields with desired data
  3. run `docker compose up -d`
  4. run `docker-compose exec app bundle exec rake db:setup db:migrate`
  5. Navigate to `localhost:3001`
