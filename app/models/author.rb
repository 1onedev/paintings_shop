class Author < ApplicationRecord
  has_many :items, dependent: :nullify, inverse_of: :author

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

  has_attached_file :image, styles: { xs: '100x100#', sm: '269x269#', lg: '1000x1000#' },
                            convert_options: { xs: '-quality 70', sm: '-quality 70', lg: '-quality 70' }

  validates_attachment :image, content_type: { content_type: /^image\/(jpeg|jpg|png|gif)$/ },
                               size: { in: 0..5.megabytes }
end