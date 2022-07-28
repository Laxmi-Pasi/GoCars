class MainCarImageUploader < CarrierWave::Uploader::Base
  include Sprockets::Rails::Helper

  include Cloudinary::CarrierWave
  process :tags => ["main_car_images"]
  process :convert => "jpg"

  version :thumbnail do
    eager
    resize_to_fit(150,150)
    # cloudinary_transformation :quality => 80
  end
end
