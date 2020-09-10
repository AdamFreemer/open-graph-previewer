class PagesController < ApplicationController
  def index
  end

  def create
    page = Page.create(page_url: URI.decode(params[:url]))
    FetchUrlOgImageJob.perform_now(page)

    render json: { page_url: page.page_url, page_id: page.id }
  end

  def show
    page = Page.find(params[:id])

    render json: { processed: page.processed, og_image_url: page.og_image_url }
  end
end
