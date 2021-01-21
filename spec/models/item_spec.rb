require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    describe '商品新規登録' do
      context '商品新規登録ができるとき' do
        it 'image、item_name、explanation、category_id、state_id、ship_method_id、ship_area_id、ship_date_id、priceが存在すれば登録できる' do
          expect(@item).to be_valid
        end
      end
      context '商品新規登録ができないとき' do
        it 'imageが空では登録できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end
        it 'item_nameが空では登録できない' do
          @item.item_name = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Item name can't be blank")
        end
        it 'explanationが空では登録できない' do
          @item.explanation = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Explanation can't be blank")
        end
        it 'category_idが1では登録できない' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Category must be other than 1')
        end
        it 'state_idが1では登録できない' do
          @item.state_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('State must be other than 1')
        end
        it 'ship_method_idが1では登録できない' do
          @item.ship_method_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Ship method must be other than 1')
        end
        it 'ship_area_idが1では登録できない' do
          @item.ship_area_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Ship area must be other than 1')
        end
        it 'ship_date_idが1では登録できない' do
          @item.ship_date_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Ship date must be other than 1')
        end
        it 'priceが空では登録できない' do
          @item.price = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is not a number')
        end
        it 'priceが半角数字でないと登録できない' do
          @item.price = 'abcd'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is not a number')
        end
        it 'priceが全角数字だと登録できない' do
          @item.price = '１２３４'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is not a number')
        end
        it 'priceが¥300未満だと登録できない' do
          @item.price = '299'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
        end
        it 'priceが¥9,999,999以上だと登録できない' do
          @item.price = '100000000'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
        end
      end
    end
  end
end
