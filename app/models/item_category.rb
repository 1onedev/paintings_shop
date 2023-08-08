class ItemCategory < ApplicationRecord
  include PgSearch

  has_many :items, dependent: :nullify, inverse_of: :item_category

  scope :search, ->(q) { pg_search(q) if q.present? }
  pg_search_scope :pg_search, against: :name,
                              using: {
                                tsearch: { prefix: true, any_word: true }
                              }

  def name
    if I18n.locale == :en && name_en.present?
      name_en
    else
      super
    end
  end
end