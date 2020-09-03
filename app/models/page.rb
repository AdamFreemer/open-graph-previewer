class Page < ApplicationRecord
  require 'open-uri'

  def self.photo_from_url(url)
    return if og_image(url).blank?

    og_image(url).first.attributes['content'].value
  end

  def self.og_image(url)
    Nokogiri::HTML(open(url)).css("meta[property='og:image']")
  end
end
