FactoryGirl.define do
  factory :user do
    name { Faker::StarWars.character }
    email { Faker::Internet.email }
    password "correct battery horse staple"
  end
end