class ReviewSearchForm
  include ActiveModel::Model

  attr_accessor :keyword, :status, :rank, :category_id, :tag_id
end
