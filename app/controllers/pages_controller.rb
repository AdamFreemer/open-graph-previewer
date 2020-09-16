class PagesController < ApplicationController
  def index
  end

  def create
    # A resource create is triggered on form submit from the javascript front-end.
    page = Page.create(page_url: params[:url])
    FetchUrlOgImageJob.perform_now(page)

    render json: { page_url: page.page_url, page_id: page.id }
  end

  def show
    # The show action returns the 
    page = Page.find(params[:id])

    render json: { processed: page.processed, og_image_url: page.og_image_url }
  end
end
