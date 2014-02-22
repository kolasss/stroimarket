class UserPictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  version :middle do
    process resize_to_fill: [ 200, 200 ]
  end

  version :mini, from: :middle do
    process resize_to_fill: [ 28, 28 ]
  end

  def store_dir
    "uploads/user/picture/#{model.id}"
  end

  def default_url
    'profile/' + [ version_name, 'default.png' ].compact.join('_')
  end
end
