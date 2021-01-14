# テーブル設計

## usersテーブル

|Column                |Type     |Options                   |
|----------------------|---------|--------------------------|
| nickname             | string  | null: false              |
| e-mail               | string  | null: false, unique: true|
| encrypted_password   | string  | null: false              |
| last_name            | string  | null: false              |
| first_name           | string  | null: false              |
| last_name_kana       | string  | null: false              |
| first_name_kana      | string  | null: false              |
| birth_year           | integer | null: false              |
| birth_month          | integer | null: false              |
| birth_day            | integer | null: false              |

### Association
- has_many :items
- has_many :item_buyers

## itemsテーブル

|Column         |Type        |Options                        |
|---------------|------------|-------------------------------|
| item_name     | string     | null: false                   |
| explanation   | text       | null: false                   |
| category_id   | text       | null: false                   |
| state_id      | text       | null: false                   |
| ship_method_id| text       | null: false                   |
| ship_area_id  | string     | null: false                   |
| ship_date_id  | date       | null: false                   |
| price         | integer    | null: false                   |
| user          | references | null: false, foreign_key: true|

### Association
- belongs_to :user
- has_one :item_buyer

## item_usersテーブル

|Column|Type        |Options          |
|------|------------|-----------------|
|user  | references |foreign_key: true|
|item  | references |foreign_key: true|

### Association
- belongs_to :item
- belongs_to :user
- has_one :buyer

## buyersテーブル

|Column          |Type     |Options      |
|----------------|---------|-------------|
| postal_code    | integer | null: false |
| prefectures    | text    | null: false |
| municipalities | text    | null: false |
| address        | text    | null: false |
| building       | text    |             |
| phone_number   | integer | null: false |

### Association
- belongs_to :item_user