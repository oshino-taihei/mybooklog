class Category < ActiveRecord::Base
  belongs_to :user

  NAME_MAX_LENGTH = 25
  validates :category_name,
    presence: true,
    length: { maximum: NAME_MAX_LENGTH },
    uniqueness: { scope: [:user_id] }
end
