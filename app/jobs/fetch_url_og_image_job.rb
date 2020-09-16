class FetchUrlOgImageJob < ApplicationJob
  require 'open-uri'
  queue_as :default

  def perform(page)
    fetch_og_image_url(page)
  end

  def fetch_og_image_url(page)
    og_image_url = nil
    # If no url is entered on the front end, we filter out that behavior with the below guard clause.
    return if page.page_url.blank?

    og_image_attributes = Nokogiri::HTML(URI.open(page.page_url)).css("meta[property='og:image']").first
    # if no open graph image is found don't populate og_image
    return if og_image_attributes.nil?
    # Sometimes the og_image tag can exist but still have no content, so additional error handling is performed below.
    og_image_url = URI.parse(og_image_attributes.attributes['content']&.value) unless og_image_attributes.attributes['content'].nil?
    # If no open graph image exists for url, og_image_url = nil && processed: true deliniates that for front end.
    page.update(og_image_url: og_image_url, processed: true)
  end
end
