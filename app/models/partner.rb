class Partner < ApplicationRecord
  has_attached_file :image,
                    styles: { xs: '204x109#' },
                    convert_options: { xs: '-quality 70' }

  validates_attachment :image, content_type: { content_type: IMG_TYPES }, size: { in: IMG_SIZES }
end