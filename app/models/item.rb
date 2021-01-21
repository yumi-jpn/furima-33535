class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :ship_method
  belongs_to :ship_area
  belongs_to :ship_date
  belongs_to :user
  has_one_attached :image
 
  with_options presence:true do
    validates :image
    validates :item_name
    validates :explanation
  end
  
  with_options numericality: { other_than: 1 } do # ジャンルの選択が「---」の時は保存できないようにする
    validates :category_id 
    validates :state_id
    validates :ship_method_id
    validates :ship_area_id
    validates :ship_date_id
  end

  validates :price, presence:true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
end
