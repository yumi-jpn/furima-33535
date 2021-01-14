# テーブル設計

## usersテーブル

|Column                |Type     |Options      |
|----------------------|---------|-------------|
| nickname             | string  | null: false |
| e-mail               | string  | null: false |
| password             | string  | null: false |
|password_confirmation | string  | null: false |
| last_name            | string  | null: false |
| first_name           | string  | null: false |
| last_name_kana       | string  | null: false |
| first_name_kana      | string  | null: false |
| birth_year           | integer | null: false |
| birth_month          | integer | null: false |
| birth_day            | integer | null: false |

### Association
- has_many :items
- has_many :item_buyers

## itemsテーブル

|Column       |Type        |Options      |
|-------------|------------|-------------|
| image       |            |             |
| item_name   | string     | null: false |
| explanation | text       | null: false |
| category    | text       | null: false |
| state       | text       | null: false |
| ship_method | text       | null: false |
| ship_area   | string     | null: false |
| ship_date   | date       | null: false |
| price       | integer    | null: false |
| user        | references | null: false |

### Association
- belongs_to :user
- has_one :item_buyer

## item_usersテーブル

|Column|Type        |Options|
|------|------------|-------|
|buyer | references |       |
|item  | references |       |

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