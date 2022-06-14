CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     ENV["aws_api_key"],
        aws_secret_access_key: ENV["aws_api_secret"],
        region: 'us-east-1'
    }
    config.fog_directory  = "simplenetwork"
    config.fog_public     = false
    config.cache_dir     = "#{Rails.root}/tmp/uploads"         # To let CarrierWave work on Heroku
    config.storage       = :fog
  end