class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  has_and_belongs_to_many :tags

  enum status: %w(- 読みたい いま読んでる 読み終わった 積読)
  enum rank: %w(評価しない ★ ★★ ★★★ ★★★★ ★★★★★)

  def tag_names
    self.tags.map(&:tag_name).join(', ')
  end

  def tag_names=(tag_names)
    new_tags = tag_names.split(',').map(&:strip).map do |tag_name|
      Tag.find_or_create_by(tag_name: tag_name)
    end
    self.tags = new_tags
  end
end
