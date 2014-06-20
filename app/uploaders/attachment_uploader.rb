class AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  include CarrierWave::MiniMagick

  # storage :fog

  process :set_content_type
  process :cache_meta

  def meta
    @meta || model[:file_meta]
  end

  def cache_meta
    @meta = { type: file.content_type, size: file.size }

    if image?
      manipulate! do |img|
        @meta[:width], @meta[:height] = img[:dimensions]
        img
      end
    end
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def image?
    file.content_type =~ /^image\//
  end

  def move_to_cache
    true
  end

  def move_to_store
    true
  end
end
