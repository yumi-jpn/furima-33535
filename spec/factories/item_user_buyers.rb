FactoryBot.define do
  factory :item_user_buyer do
    postal_code { '111-1111' }
    ship_area_id { 2 }
    municipalities { '東京都' }
    address { '1-1' }
    building { '東京ハイツ' }
    phone_number { '01023456789' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
