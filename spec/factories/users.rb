FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname               { Faker::Name.initials(number: 2) }
    email                  { Faker::Internet.free_email }
    password               { Faker::Internet.password(min_length: 6) }
    password_confirmation  { password }
    last_name              { person.first.kanji }
    first_name             { person.last.kanji }
    last_name_kana         { person.first.katakana }
    first_name_kana        { person.last.katakana }
    birth_date             { '1990-04-01' }
  end
end
