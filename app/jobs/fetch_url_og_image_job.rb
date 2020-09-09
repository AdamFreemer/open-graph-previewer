class FetchUrlOgImageJob < ApplicationJob
  require 'open-uri'
  queue_as :default

  def perform(page)
    puts "== og job executed"
    FetchUrlOgImageJob.fetch_og_image_url(page)
  end

  def self.fetch_og_image_url(page)
    return if url.blank?

    og_image_attributes = Nokogiri::HTML(open(page.url)).css("meta[property='og:image']").first
    return if og_image_attributes.nil?

    og_image_url = og_image_attributes.attributes['content'].value
    page = Page.find(page.id)
    page.update(og_image: og_image_url)
  end
end
