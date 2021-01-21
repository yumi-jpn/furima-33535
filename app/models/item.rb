class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :ship_method
  belongs_to :ship_area
  belongs_to :ship_date
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true
  validates :item_name, presence: true
  validates :explanation, presence: true
  validates :category_id, numericality: { other_than: 1 } # ジャンルの選択が「---」の時は保存できないようにする
  validates :state_id, numericality: { other_than: 1 }
  validates :ship_method_id, numericality: { other_than: 1 }
  validates :ship_area_id, numericality: { other_than: 0 }
  validates :ship_date_id, numericality: { other_than: 1 }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                    format: { with: /\A[0-9]+\z/ }
end
