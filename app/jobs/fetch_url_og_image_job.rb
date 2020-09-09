class FetchUrlOgImageJob < ApplicationJob
  require 'open-uri'
  queue_as :default

  def perform(url)
    puts "== og job executed"
    @page = Page.create(processed: false)
    og_image_url = FetchUrlOgImageJob.fetch_og_image_url(url)

  end

  def self.fetch_og_image_url(url)
    return if url.blank?

    og_image_attributes = Nokogiri::HTML(open(url)).css("meta[property='og:image']").first
    return if og_image_attributes.nil?

    og_image_url = og_image_attributes.attributes['content'].value
  end


end
