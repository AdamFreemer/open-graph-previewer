class FetchUrlOgImageJob < ApplicationJob
  require 'open-uri'
  queue_as :default

  def perform(page)
    puts "== og job executed: "
    fetch_og_image_url(page)
  end

  def fetch_og_image_url(page)
    return if page.page_url.blank?

    og_image_attributes = Nokogiri::HTML(open(page.page_url)).css("meta[property='og:image']").first
    # if no open graph image is found don't populate og_image
    og_image_url = og_image_attributes.attributes['content'].value unless og_image_attributes.nil?
    # if no open graph image exists for url, og_image_url = nil && processed: true deliniates that for front end
    page.update(og_image_url: og_image_url, processed: true)
    puts "== page: #{page.page_url} processed."
  end
end
