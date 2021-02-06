require 'rails_helper'

RSpec.describe Prototype, type: :model do
  before do
    @prototype = FactoryBot.build(:prototype)
  end

  describe "prototypeの保存" do
    context "prototypeが投稿できる場合" do
      it "全部あれば投稿できる" do
        expect(@prototype).to be_valid
      end
    end
    context "prototypeが投稿できない" do
      it "titleが空では投稿できない" do
        @prototype.title = nil
        @prototype.valid?
        expect(@prototype.errors.full_messages).to include "Title can't be blank"
      end
      it "catch_copyが空では投稿できない" do
        @prototype.catch_copy = nil
        @prototype.valid?
        expect(@prototype.errors.full_messages).to include "Catch copy can't be blank"
      end
      it "conceptがからでは投稿できない" do
        @prototype.concept = nil
        @prototype.valid?
        expect(@prototype.errors.full_messages).to include "Concept can't be blank"
      end
      it "imageがからでは投稿できない" do
        @prototype.image = nil
        @prototype.valid?
        expect(@prototype.errors.full_messages).to include "Image can't be blank"
      end
      it "userが紐付いていなければ投稿できない" do
        @prototype.user = nil
        @prototype.valid?
        expect(@prototype.errors.full_messages).to include "User must exist"
      end
    end
  end
end
