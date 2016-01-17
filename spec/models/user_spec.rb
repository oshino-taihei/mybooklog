require 'rails_helper'

describe User, type: :model do
  it 'nameがあれば正常であること' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'nameがなければエラーであること' do
    user = build(:user, name: nil)
    expect(user).not_to be_valid
  end

  it 'nameに重複があればエラーであること' do
    user_name = "User Name"
    user1 = create(:user, name: user_name)
    user2 = build(:user, name: user_name)
    expect(user2).not_to be_valid
  end

  describe 'ユーザのフォロー/アンフォローができること' do
    before :each do
      @user1 = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
      @user4 = create(:user)
      @user1.follow(@user2)
      @user1.follow(@user3)
    end

    it '別ユーザをフォローできること' do
      expect(@user1.following.count).to eq 2
      expect(@user2.followers.count).to eq 1
      expect(@user3.followers.count).to eq 1
      expect(@user4.followers.count).to eq 0
      expect(@user1.following).to include @user2
      expect(@user1.following).to include @user3
      expect(@user2.followers).to include @user1
      expect(@user3.followers).to include @user1
    end

    it 'フォローしたユーザをアンフォローできること' do
      @user1.unfollow(@user2)

      expect(@user1.following.count).to eq 1
      expect(@user2.followers.count).to eq 0
      expect(@user3.followers.count).to eq 1
      expect(@user4.followers.count).to eq 0
      expect(@user1.following).not_to include @user2
      expect(@user1.following).to include @user3
      expect(@user2.followers).not_to include @user1
      expect(@user3.followers).to include @user1
    end

    it 'フォロー済みのユーザを判定できること' do
      expect(@user1.following?(@user1)).to be_falsy
      expect(@user1.following?(@user2)).to be_truthy
      expect(@user1.following?(@user3)).to be_truthy
      expect(@user1.following?(@user4)).to be_falsy
    end
  end

  describe '自身のレビューを取得できること' do
    before :each do
      @user = create(:user)
      @review1 = build(:review, status: 0)
      @review2 = build(:review, status: 1)
      @review3 = build(:review, status: 1)
      @review4 = build(:review, status: 2)
      @review5 = build(:review, status: 4)
      @review6 = build(:review, status: 4)
      @review7 = build(:review, status: 4)
      @review8 = build(:review, status: 4)
      @review9 = build(:review, status: 4)
      @review10 = build(:review, status: 4)
      @user.reviews << [@review1, @review2, @review3, @review4, @review5, @review6, @review7, @review8, @review9, @review10]
      @user.save!

      @other_user1 = create(:user)
      @review_a = build(:review, status: 1)
      @review_b = build(:review, status: 3)
      @review_c = build(:review, status: 3)
      @review_d = build(:review, status: 3)
      @review_e = build(:review, status: 2)
      @review_f = build(:review, status: 0)
      @other_user1.reviews << [@review_a, @review_b, @review_c, @review_d, @review_e, @review_f]
      @other_user1.save!

      @other_user2 = create(:user)
      @review_g = build(:review, status: 0)
      @review_h = build(:review, status: 1)
      @other_user2.reviews << [@review_g, @review_h]
      @other_user2.save!

      @user.follow(@other_user1)
      @user.follow(@other_user2)
    end

    it '自身のレビューをステータスごとに集計できること' do
      status_count = @user.status_count
      expect(status_count.keys).to eq ["読みたい", "いま読んでる", "読み終わった", "積読", "-"]
      expect(status_count["-"]).to eq 1
      expect(status_count["読みたい"]).to eq 2
      expect(status_count["いま読んでる"]).to eq 1
      expect(status_count["読み終わった"]).to eq 0
      expect(status_count["積読"]).to eq 6
    end

    it '自身のレビューから特定のステータスの最近のものを指定件数分、取得できること' do
      recent_reviews = @user.recent_reviews_by_status("積読", 5)
      expect(recent_reviews.size).to eq 5
      expect(recent_reviews[0]).to eq @review10
      expect(recent_reviews[1]).to eq @review9
      expect(recent_reviews[2]).to eq @review8
      expect(recent_reviews[3]).to eq @review7
      expect(recent_reviews[4]).to eq @review6
    end

    it 'フォローしているユーザの最近のレビューを指定件数分、取得できること' do
      recent_followings_reviews = @user.recent_followings_reviews(5)
      expect(recent_followings_reviews.size).to eq 5
      expect(recent_followings_reviews[0]).to eq @review_h
      expect(recent_followings_reviews[1]).to eq @review_g
      expect(recent_followings_reviews[2]).to eq @review_f
      expect(recent_followings_reviews[3]).to eq @review_e
      expect(recent_followings_reviews[4]).to eq @review_d
    end
  end
end
