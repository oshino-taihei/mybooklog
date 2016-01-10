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

end
