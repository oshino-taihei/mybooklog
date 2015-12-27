class User < ActiveRecord::Base
  has_many :reviews
  has_many :books, through: :reviews

  validates :name,
    presence: true,
    uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def to_param
    name
  end
end
