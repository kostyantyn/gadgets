# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :small do
    process resize_to_fit: [250, 250]
  end

  version :large do
    process resize_to_fit: [800, 800]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
