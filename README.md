# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

rails new ecommerce_webhooks
rails g model Product name:string price:decimal
rails g model Order customer_id:integer product_id:integer quantity:integer total_price:decimal
rails g model Customer name:string email:string address:string

rails g controller Products
rails g controller Orders
rails g controller Customers

check all above three model and controller code
routes code

/home/spr05/work/ecommerce_webhooks/config/initializers/third_party_config.rb
check code

/home/spr05/work/ecommerce_webhooks/app/helpers/application_helper.rb
check code

/home/spr05/work/ecommerce_webhooks/app/controllers/application_controller.rb
check code


gem 'httparty'
file add 

rails db:migrate
bundle install
