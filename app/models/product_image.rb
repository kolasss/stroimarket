class ProductImage < Attachment
  mount_uploader :file, ProductImageUploader

  validates :file, file_size: { maximum: 4.megabyte },
                   image_size: { max_width: 2048 }
end
