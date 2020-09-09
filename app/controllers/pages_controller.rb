class PagesController < ApplicationController
  def index
  end

  def create
    page = Page.create(url: URI.decode(params[:url]))
    FetchUrlOgImageJob.perform_now(page)

    render json: { page_being_processed: page.url, page_id: page.id }
  end

  def show
    page = Page.find(params[:page_id])

    render json: { job_processed: page.procesed, og_image_url: page.og_image }
  end
end
