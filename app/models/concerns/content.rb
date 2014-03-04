module Content
  extend ActiveSupport::Concern

  included do
    embeds_many :images, as: :attachable, cascade_callbacks: true
    embeds_many :documents, as: :attachable, cascade_callbacks: true

    accepts_nested_attributes_for :images, :documents, allow_destroy: true

    field :title, type: String
    field :intro, type: String
    field :body, type: String

    mount_uploader :cover, ImageUploader

    validates :title, :presence => true
    validates :body, :presence => true
    validates :cover, file_size: { maximum: 4.megabyte },
                      image_size: { max_width: 2048 },
                      allow_blank: true
  end

  # module ClassMethods

  # end
end
