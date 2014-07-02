# для русских символов в загружаемых файлах
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV['S3_KEY'],                        # required
    :aws_secret_access_key  => ENV['S3_SECRET'],                        # required
    :region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
    # :host                   => 'https://s3-eu-west-1.amazonaws.com',             # optional, defaults to nil
    # :endpoint               => 'https://s3-eu-west-1.amazonaws.com:8080' # optional, defaults to nil
    # :path_style            => true
  }

  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"

  # elsif Rails.env.development?
  #   config.storage = :file
  else
    config.storage = :fog
  end

  config.fog_directory  = ENV['S3_BUCKET']                     # required
  # config.fog_public     = false                                   # optional, defaults to true
  # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  config.cache_dir     = "#{Rails.root}/tmp/uploads"   # For Heroku
end
