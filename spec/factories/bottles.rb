
FactoryGirl.define do
    factory :bottle do
        name { Faker::Book.title }
        winery { Faker::Book.publisher }
        vintage { Faker::Number.number(4) }
        description { Faker::Hipster.sentence }
        cellar_id nil
    end
end
