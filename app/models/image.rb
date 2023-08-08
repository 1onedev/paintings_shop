class Image < ApplicationRecord
  default_scope { order(position: :asc) }

  belongs_to :imageable, polymorphic: true

  has_attached_file :file,
    styles: { xs: '100x100#', sm: '269x269#', lg: '1000x1000#', zoom: '1500x1500#' },
    convert_options: { xs: '-quality 70', lg: '-quality 70', zoom: '-quality 70' }

  validates_attachment :file, content_type: { content_type: IMG_TYPES }, size: { in: IMG_SIZES }
end
