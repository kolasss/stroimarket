class ImageUploader < AttachmentUploader
  version :large do
    process resize_to_fill: [ 940, 530 ]
  end

  version :middle, from_version: :large do
    process resize_to_fill: [ 620, 350 ]
  end

  version :thumb, from_version: :middle do
    process resize_to_fill: [ 140, 100 ]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
