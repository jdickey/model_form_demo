
require 'faker'

FactoryGirl.define do
  factory :thing do
    name { Faker::Commerce.product_name }
    initial_quantity { rand(1..10) }
    description { Faker::Lorem.sentence }
  end
end
