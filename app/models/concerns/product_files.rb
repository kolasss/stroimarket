module ProductFiles
  extend ActiveSupport::Concern

  included do
    embeds_many :product_images, as: :attachable, cascade_callbacks: true

    accepts_nested_attributes_for :product_images, allow_destroy: true

    mount_uploader :cover, ProductImageUploader

    validates :cover, file_size: { maximum: 4.megabyte },
                      image_size: { max_width: 2048 },
                      allow_blank: true
  end
end
