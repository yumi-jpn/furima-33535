# テーブル設計

## usersテーブル

|Column                |Type     |Options                   |
|----------------------|---------|--------------------------|
| nickname             | string  | null: false              |
| email                | string  | null: false, unique: true|
| encrypted_password   | string  | null: false              |
| last_name            | string  | null: false              |
| first_name           | string  | null: false              |
| last_name_kana       | string  | null: false              |
| first_name_kana      | string  | null: false              |
| birth_date           | date    | null: false              |

### Association
- has_many :items
- has_many :item_users

## itemsテーブル

|Column         |Type        |Options                        |
|---------------|------------|-------------------------------|
| item_name     | string     | null: false                   |
| explanation   | text       | null: false                   |
| category_id   | integer    | null: false                   |
| state_id      | integer    | null: false                   |
| ship_method_id| integer    | null: false                   |
| ship_area_id  | integer    | null: false                   |
| ship_date_id  | integer    | null: false                   |
| price         | integer    | null: false                   |
| user          | references | null: false, foreign_key: true|

### Association
- belongs_to :user
- has_one :item_user

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

|Column          |Type      |Options                         |
|----------------|----------|--------------------------------|
| postal_code    | string   | null: false                    |
| ship_area_id   | integer  | null: false                    |
| municipalities | string   | null: false                    |
| address        | string   | null: false                    |
| building       | string   |                                |
| phone_number   | string   | null: false                    |
| item_users     |references| null: false, foreign_key: true |

### Association
- belongs_to :item_user