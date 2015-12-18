class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  enum status: %w(- 読みたい いま読んでる 読み終わった 積読)
  enum rank: %w(評価しない ★ ★★ ★★★ ★★★★ ★★★★★)
end
