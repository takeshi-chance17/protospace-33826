require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context "新規登録できるとき" do
      it "全部が存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context "新規登録できないとき" do
      it "nameが空では登録できない" do
        @user.name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Name can't be blank"
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = "Password confirmation doesn't match Password"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it "profileが空では登録できない" do
        @user.profile = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Profile can't be blank"
      end
      it "occupationが空では登録できない" do
        @user.occupation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Occupation can't be blank"
      end
      it "positionがからでは登録できない" do
        @user.position = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Position can't be blank"
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        @another = FactoryBot.build(:user)
        @another.email = @user.email
        @another.valid?
        expect(@another.errors.full_messages).to include "Email has already been taken"
      end
      it "passwordが5文字以下では登録できない" do
        @user.password = "00000"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end
    end
  end
end
