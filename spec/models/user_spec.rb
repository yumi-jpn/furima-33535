require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nickname,email,password,password_confirmation,last_name, first_name,last_name_kana, first_name_kana,birth_dateが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'emailは、@が入っていれば登録できる' do
        @user.email = 'test@example'
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = '00000a'
        @user.password_confirmation = '00000a'
        expect(@user).to be_valid
      end
      it 'last_name, first_nameが全角の漢字、ひらがな、カタカナであれば登録できる' do
        @user.last_name = '全角カタかな'
        @user.first_name = '全角カタかな'
        expect(@user).to be_valid
      end
      it 'last_name_kana, first_name_kanaが全角カタカナであれば登録できる' do
        @user.last_name_kana = 'カタカナ'
        @user.first_name_kana = 'カタカナ'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailは一意性がないと登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@が含まれていないと登録できない' do
        @user.email = 'test.example'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordは6文字以上でないと登録できない' do
        @user.password = '0000a'
        @user.password_confirmation = '0000a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordは半角英数字混合でないと登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordは英語のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordは数字のみでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordは確認も含めて2回入力しないと登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordと確認用passwordが一致していないと登録できない' do
        @user.password = '00000a'
        @user.password_confirmation = '00000b'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_nameは全角の漢字、ひらがな、カタカナでの入力出ないと登録できない' do
        @user.last_name = 'abcde'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameは全角の漢字、ひらがな、カタカナでの入力出ないと登録できない' do
        @user.first_name = 'abcde'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it 'last_name_kanaは空では保存できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'last_name_kanaは全角のカタカナでの入力出ないと登録できない' do
        @user.last_name_kana = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'first_name_kanaは全角のカタカナでの入力出ないと登録できない' do
        @user.first_name_kana = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
