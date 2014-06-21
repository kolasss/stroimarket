module PostFiles
  extend ActiveSupport::Concern

  included do
    embeds_many :images, as: :attachable, cascade_callbacks: true
    embeds_many :documents, as: :attachable, cascade_callbacks: true

    accepts_nested_attributes_for :images, :documents, allow_destroy: true

    mount_uploader :cover, ImageUploader

    validates :cover, file_size: { maximum: 4.megabyte },
                      image_size: { max_width: 2048 },
                      allow_blank: true, if: :cover_changed?
  end
end
