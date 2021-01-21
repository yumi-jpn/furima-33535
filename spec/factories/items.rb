FactoryBot.define do
  factory :item do
    item_name           { Faker::Commerce.product_name }
    explanation         { Faker::Lorem.sentence }
    category_id         { Faker::Number.between(from: 2, to: 11) }
    state_id            { Faker::Number.between(from: 2, to: 7) }
    ship_method_id      { Faker::Number.between(from: 2, to: 3) }
    ship_area_id        { Faker::Number.between(from: 1, to: 48) }
    ship_date_id        { Faker::Number.between(from: 2, to: 4) }
    price               { Faker::Number.within(range: 300..9_999_999) }
    association :user   # アソシエーション

    after(:build) do |item|
      item.image.attach(io: File.open('public/test_image.png'), filename: 'test_image.png')
    end
  end
end
