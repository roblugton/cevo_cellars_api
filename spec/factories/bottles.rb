
FactoryGirl.define do
    factory :botte do
        name { Faker::Book.title }
        winery { Faker::Book.publisher }
        year { Faker::Number.number(4) }
        description { Faker::Coffee.notes }
        done false
        cellar_id nil
    end
end
