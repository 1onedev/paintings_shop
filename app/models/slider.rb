class Slider < ApplicationRecord
  has_attached_file :image, styles: { sm: '500x263#', lg: '1140x600#' },
                            convert_options: { sm: '-quality 70', lg: '-quality 70' }

  validates_attachment :image, content_type: { content_type: /^image\/(jpeg|jpg|png|gif)$/ },
                               size: { in: 0..5.megabytes }
end