class User < ActiveRecord::Base
  has_many :reviews
  has_many :books, through: :reviews
  has_many :tags, through: :reviews
  has_many :categories
  has_many :from_follows, class_name:  "Follow",
                     foreign_key: "from_user_id",
                     dependent:   :destroy
  has_many :following, through: :from_follows, source: :to_user
  has_many :to_follows, class_name:  "Follow",
                     foreign_key: "to_user_id",
                     dependent:   :destroy
  has_many :followers, through: :to_follows, source: :from_user

  validates :name, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def to_param
    name
  end

  def follow(other_user)
    self.from_follows.create(to_user_id: other_user.id)
  end

  def unfollow(other_user)
    self.from_follows.find_by(to_user_id: other_user.id).destroy
  end

  def following?(other_user)
    self.from_follows.exists?(to_user_id: other_user.id)
  end

  def status_count
    existed_status_count = self.reviews.group(:status).order(:status).count(:status)
    all_status_count = Review.statuses.map do |status_label, status_value|
      [status_label, existed_status_count[status_value] || 0]
    end
    # statusでorder byしているので先頭は0("-":未設定)になるが、
    # 表示上はこれだけを一番後ろにもっていきたいため、rotateしている
    all_status_count.rotate.to_h
  end

  def recent_reviews_by_status(status_value, limit_count = 5)
    self.reviews.where(status: Review.statuses[status_value]).order(created_at: :desc).limit(limit_count)
  end

  def recent_followings_reviews(limit_count = 50)
    Review.includes(:user, :book).where(user: self.following).order(created_at: :desc).limit(limit_count)
  end
end
