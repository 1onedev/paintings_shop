class ItemMaterial < ApplicationRecord
  has_many :items, dependent: :nullify, inverse_of: :item_material

  def name
    if I18n.locale == :en && name_en.present?
      name_en
    else
      super
    end
  end
end