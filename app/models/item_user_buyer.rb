class ItemUserBuyer
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :postal_code, :ship_area_id, :municipalities, :address, :building, :phone_number,
                :item_user_id

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :municipalities, format: { with: /\A[ぁ-んァ-ン一-龥々]/ }
    validates :address
    validates :phone_number, numericality: { only_integer: true }
    validates :ship_area_id, numericality: { other_than: 1 }
    validates :token
  end

  def save
    # # ユーザーの情報を保存し、「user」という変数に入れている
    # user = User.create(nickname: nickname, email: email, encrypted_password: encrypted_password, last_name: last_name, first_name: first_name, last_name_kana: last_name_kana, first_name_kana: first_name_kana, birth_date: birth_date)
    # # 商品の情報を保存し、「item」という変数に入れている
    # item = Item.create(item_name: item_name, explanation: explanation, category_id: category_id, state_id: state_id, ship_method_id: ship_method_id, ship_area_id: ship_area_id, ship_date_id: ship_date_id, price: price, user_id: user.id)
    # #購入情報(誰がいつどの商品の購入をしたか)の保存
    item_user = ItemUser.create(user_id: user_id, item_id: item_id)
    # 配送先・住所情報の保存
    Buyer.create(postal_code: postal_code, ship_area_id: ship_area_id, municipalities: municipalities, address: address,
                 building: building, phone_number: phone_number, item_user_id: item_user.id)
    # ここの水色表記の部分はpermitを参照している！
  end
end
