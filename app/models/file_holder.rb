class FileHolder < ActiveFedora::Base
  include Hydra::PCDM::ObjectBehavior
  include Hydra::Derivatives

  contains 'original_file'
  contains 'thumbnail'
  contains 'access'

  #makes_derivatives :generate_derivatives

  def generate_derivatives
    case self.original_file.mime_type
      when 'application/pdf'
            transform_file :original_file, { :thumb => "300x300>" }

=begin
        img = Magick::Image.read(self.original_file.uri.to_s) {
          self.quality = 100
          self.density = 200
        }.first

        img = Magick::Image.from_blob( img.to_blob { self.format = "jpg" } ).first

        thumb = img.resize_to_fit(300,300)

        self.thumb.content = thumb.to_blob { self.format = "jpg" }
        self.thumb.mime_type = 'image/jpeg'
        self.thumb.label = url.split('/').last.gsub(/\....$/, '')
=end
      when 'audio/wav'
        transform_file :original_file, { :mp3 => {format: 'mp3'}, :ogg => {format: 'ogg'} }, processor: :audio
      when 'video/avi'
        transform_file :original_file, { :mp4 => {format: 'mp4'}, :webm => {format: 'webm'} }, processor: :video
      when 'image/png', 'image/jpg'
        transform_file :original_file, { :thumb => "300x300>" }
        transform_file :original_file, { :testJP2k => { recipe: :default, datastream: 'access' } }, processor: 'jpeg2k_image'
      when 'image/tiff'
        transform_file :original_file, { :testJP2k => { recipe: :default, datastream: 'access' } }, processor: 'jpeg2k_image'
        transform_file :original_file, { :thumb => "300x300>" }
    end
  end
end