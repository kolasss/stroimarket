class ImageUploader < AttachmentUploader
  version :large do
    process resize_to_fill: [ 960, 540 ]
  end

  # version :middle, from_version: :large do
  #   process resize_to_fill: [ 480, 270 ]
  # end

  version :thumb, from_version: :large do
    process resize_to_fill: [ 160, 90 ]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
