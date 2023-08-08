class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  before_create :set_price

  def total_price
    (self.item.price.to_f * count.to_f) rescue 0.0
  end

  def set_price
    self.price = total_price
  end
end
