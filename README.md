# Derm Pro App

This README document whatever steps are necessary to get the
application up and running.

* Set up database Configuration variables
** run `cp example.database.yml database.yml`

* Update you Database credentials in
** `database.yml`

* Install dependencies
** run `bundle install`

* Create database
** run `rake db:create`

* Migrate database
** run `rake db:migrate`

* Seed database
** run `rake db:seed`

**** Run the App with `rails s -p 3000` and point to `https://localhost:3000`.

********************************************************************************************************