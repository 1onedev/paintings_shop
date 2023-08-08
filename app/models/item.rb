class Item < ApplicationRecord
  include PgSearch
  include Imageable

  enum status: {
    not_sold: 0, # Не продано
    sold: 1 # Продано
  }

  scope :search, ->(q) { pg_search(q) if q.present? }
  pg_search_scope :pg_search, against: [:name],
                              using: {
                                tsearch: { prefix: true, any_word: true }
                              }

  scope :published, -> { where('published = true') }
  scope :commenting, -> { where('commenting = true') }
  scope :promo, -> { where('promo = true') }

  belongs_to :item_category, inverse_of: :items, optional: true
  belongs_to :item_material, inverse_of: :items, optional: true
  belongs_to :author, inverse_of: :items, optional: true
  has_many :comments, dependent: :nullify, inverse_of: :item
  has_many :order_items, dependent: :nullify, inverse_of: :item

  has_many :similar_items, foreign_key: :similar_id, dependent: :destroy, inverse_of: :similar
  has_many :items, through: :similar_items
  accepts_nested_attributes_for :similar_items, allow_destroy: true

  def name_with_price
    price_with_sign = ['(', price, 'грн )'].compact.join(' ')
    [name, price_with_sign].compact.join(', ')
  end

  def name
    if I18n.locale == :en && name_en.present?
      name_en
    else
      super
    end
  end

  def description
    if I18n.locale == :en && description_en.present?
      description_en
    else
      super
    end
  end
end