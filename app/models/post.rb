class Post < ApplicationRecord
  scope :published, -> { where('published = true') }

  has_attached_file :image, styles: { xs: '150x97#', sm: '366x237#', lg: '870x500#' },
                            convert_options: { xs: '-quality 70', sm: '-quality 70', lg: '-quality 70' }

  validates_attachment :image, content_type: { content_type: /^image\/(jpeg|jpg|png|gif)$/ },
                               size: { in: 0..5.megabytes }

  def name
    if I18n.locale == :en && name_en.present?
      name_en
    else
      super
    end
  end

  def text
    if I18n.locale == :en && text_en.present?
      text_en
    else
      super
    end
  end
end