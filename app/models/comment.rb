class Comment < ApplicationRecord
  belongs_to :item, inverse_of: :comments
  belongs_to :user, inverse_of: :comments, optional: true
  
  scope :unviewed, -> { where(viewed: false) }
  scope :published, -> { where('published = true') }
end