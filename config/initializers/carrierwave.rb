require 'carrierwave'
require 'fog/aws'

CarrierWave.configure do |config|

  # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  end
  
  # Use AWS storage if in production
  if Rails.env.production?
    config.storage = :fog
    
    config.fog_credentials = {
      :provider               => 'AWS',                 # required
      :aws_access_key_id      => ENV['AWS_KEY'],        # required
      :aws_secret_access_key  => ENV['AWS_SECRET'],     # required
      :region                 => 'ap-southeast-1',
      # optional, defaults to 'us-east-1'
    }

    config.fog_directory  = ENV['BUCKET_NAME']                      # required
    #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
    #config.fog_public     = false                                  # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  end
end

# config/initializers/carrierwave.rb
module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end

