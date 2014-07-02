module ProductFiles
  extend ActiveSupport::Concern

  included do
    embeds_many :images,
                as: :attachable,
                cascade_callbacks: true,
                class_name: "ProductImage",
                store_as: 'product_images'

    accepts_nested_attributes_for :images, allow_destroy: true

    mount_uploader :cover, ProductImageUploader

    validates :cover, file_size: { maximum: 4.megabyte },
                      image_size: { max_width: 2048 },
                      allow_blank: true, if: :cover_changed?
  end
end
