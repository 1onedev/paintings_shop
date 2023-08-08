class Order < ApplicationRecord
  belongs_to :user, optional: true

  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_products
  accepts_nested_attributes_for :order_items, allow_destroy: true

  has_many :transactions, dependent: :destroy

  validates :number, presence: true, uniqueness: true, on: :update

  enum status: { new_order: 0, pending: 1, paid: 2, canceled: 3 }

  enum step: { cart: 0, checkout: 1, payment: 2 }

  enum delivery_service: {
    novaposhta: 0,
    ukrposhta: 1
  }

  enum delivery_type: {
    otdelenie: 0,
    adress: 1
  }

  def total_price
    order_items.sum(&:total_price)
  end

  def full_name
    [receiver_name, receiver_surname].compact.join(' ')
  end

  def number_with_sign
    ['#', number].join
  end
end
