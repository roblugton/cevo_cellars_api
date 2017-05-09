FactoryGirl.define do
  factory :user do
    name { Faker::StarWars.character }
    email "star.wars@fake.example.com"
    password "correct battery horse staple"
  end
end