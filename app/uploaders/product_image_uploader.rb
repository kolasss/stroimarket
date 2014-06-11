class ProductImageUploader < AttachmentUploader
  version :large do
    process resize_to_fit: [ 800, 800 ]
  end

  version :middle, from_version: :large do
    process resize_to_fit: [ 10000, 220 ]
  end

  version :small, from_version: :middle do
    process resize_to_fill: [ 140, 140 ]
  end

  version :thumb, from_version: :small do
    process resize_to_fill: [ 100, 100 ]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

  def default_url
    ActionController::Base.helpers.asset_path("product/" + [version_name, "default.jpg"].compact.join('_'))
  end
end
