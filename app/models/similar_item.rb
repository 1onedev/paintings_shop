class SimilarItem < ApplicationRecord
  belongs_to :similar, class_name: 'Item', foreign_key: :similar_id, inverse_of: :similar_items
  belongs_to :item
end