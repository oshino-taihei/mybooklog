require 'rails_helper'

describe Category, type: :model do
  it 'category_nameがあれば正常であること' do
    category = build(:category)
    expect(category).to be_valid
  end

  it 'category_nameがなければエラーであること' do
    category = build(:category, category_name: nil)
    expect(category).not_to be_valid
  end

  it 'category_nameは25文字以内であれば正常であること' do
    category24 = build(:category, category_name: 'a'*24)
    expect(category24).to be_valid

    category25 = build(:category, category_name: 'a'*25)
    expect(category25).to be_valid
  end

  it 'category_nameは25文字を超えるとエラーであること' do
    category26 = build(:category, category_name: 'a'*26)
    expect(category26).not_to be_valid
  end

  describe 'ユーザごとにcategory_nameは一意であること' do
    before :each do
      @same_category_name = 'CATEGORY'
      @user1 = create(:user)
      @user1.categories.build(category_name: @same_category_name)
      @user1.save!
    end

    it '同一ユーザに重複したcategory_nameを保存するとエラーであること' do
      @user1.categories.build(category_name: @same_category_name)
      expect(@user1).not_to be_valid
    end

    it '同一category_nameでも別ユーザであれば正常に保存できること' do
      user2 = create(:user)
      user2.categories.build(category_name: @same_category_name)
      expect(user2).to be_valid
    end
  end
end
