class Category < ActiveRecord::Base
  belongs_to :user

  validates :category_name, presence: true, length: {maximum: 25}
end
