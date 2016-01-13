class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  has_and_belongs_to_many :tags

  enum status: %w(- 読みたい いま読んでる 読み終わった 積読)
  enum rank: %w(評価しない ★ ★★ ★★★ ★★★★ ★★★★★)

  scope :search, ->(review_search_form) do
    search_keyword(review_search_form.keyword)
    .search_status(review_search_form.status)
    .search_rank(review_search_form.rank)
    .search_category_id(review_search_form.category_id)
    .search_tag_id(review_search_form.tag_id)
  end

  scope :search_keyword, ->(keyword) do
    joins(:book).where('title like ?', "%#{keyword}%") if keyword.present?
  end

  scope :search_status, ->(status) do
    where(status: status) if status.present?
  end

  scope :search_rank, ->(rank) do
    where(rank: rank) if rank.present?
  end

  scope :search_category_id, ->(category_id) do
    where(category_id: category_id) if category_id.present?
  end

  scope :search_tag_id, ->(tag_id) do
    joins(:tags).where('tags.id': tag_id) if tag_id.present?
  end

  def tag_names
    self.tags.map(&:tag_name).join(', ')
  end

  def tag_names=(tag_names)
    new_tags = tag_names.split(',').map(&:strip).reject(&:blank?).map do |tag_name|
      Tag.find_or_create_by(tag_name: tag_name)
    end
    self.tags = new_tags
  end
end
