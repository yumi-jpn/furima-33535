require 'rails_helper'

RSpec.describe ItemUserBuyer, type: :model do
  describe '商品情報の登録' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @item_user_buyer = FactoryBot.build(:item_user_buyer, user_id: @user.id, item_id: @item.id)
    end

    it '全ての値が正しく入力されていれば保存できる' do
      expect(@item_user_buyer).to be_valid
    end
    it 'buildingはなくても登録ができる' do
      @item_user_buyer.building = nil
      expect(@item_user_buyer).to be_valid
    end
    it 'user_idが空だと登録できない' do
      @item_user_buyer.user_id = nil
      @item_user_buyer.valid?
      expect(@item_user_buyer.errors.full_messages).to include("User can't be blank")
    end
    it 'item_idが空だと登録できない' do
      @item_user_buyer.item_id = nil
      @item_user_buyer.valid?
      expect(@item_user_buyer.errors.full_messages).to include("Item can't be blank")
    end
    it 'postal_codeが空だと登録できない' do
      @item_user_buyer.postal_code = nil
      @item_user_buyer.valid?
      expect(@item_user_buyer.errors.full_messages).to include("Postal code can't be blank")
    end
    it 'ship_area_idが1だと登録できない' do
      @item_user_buyer.ship_area_id = 1
      @item_user_buyer.valid?
      expect(@item_user_buyer.errors.full_messages).to include('Ship area must be other than 1')
    end
    it 'municipalitiesが空だと登録できない' do
      @item_user_buyer.municipalities = nil
      @item_user_buyer.valid?
      expect(@item_user_buyer.errors.full_messages).to include("Municipalities can't be blank")
    end
    it 'addressがないと登録できない' do
      @item_user_buyer.address = nil
      @item_user_buyer.valid?
      expect(@item_user_buyer.errors.full_messages).to include("Address can't be blank")
    end
    it 'phone_numberがないと登録できない' do
      @item_user_buyer.phone_number = nil
      @item_user_buyer.valid?
      expect(@item_user_buyer.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'postal_codeが半角のハイフンを含んだ正しい形式でないと登録できない' do
      @item_user_buyer.postal_code = 1234 - 567
      @item_user_buyer.valid?
      expect(@item_user_buyer.errors.full_messages).to include('Postal code is invalid')
    end
    it 'postal_codeは全角数字だと保存できない' do
      @item_user_buyer.postal_code = '１２３ー４５６７'
      @item_user_buyer.valid?
      expect(@item_user_buyer.errors.full_messages).to include('Postal code is invalid')
    end
    it 'postal_codeはハイフンがないと登録できない' do
      @item_user_buyer.postal_code = 1_234_567
      @item_user_buyer.valid?
      expect(@item_user_buyer.errors.full_messages).to include('Postal code is invalid')
    end
    it 'phone_numeberは全角数字だと登録できない' do
      @item_user_buyer.phone_number = '０９０１２３４５６７８'
      @item_user_buyer.valid?
      expect(@item_user_buyer.errors.full_messages).to include('Phone number is not a number')
    end
    it 'phone_numberはハイフンが入っていると登録できない' do
      @item_user_buyer.phone_number = '090-1234-5678'
      @item_user_buyer.valid?
      expect(@item_user_buyer.errors.full_messages).to include('Phone number is not a number')
    end
    it 'tokenが空では登録できない' do
      @item_user_buyer.token = nil
      @item_user_buyer.valid?
      expect(@item_user_buyer.errors.full_messages).to include("Token can't be blank")
    end
  end
end
