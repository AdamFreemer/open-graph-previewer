require 'rails_helper'

RSpec.describe FetchUrlOgImageJob, type: :job do
  include ActiveJob::TestHelper
  let(:page) { Page.create(page_url: 'http://www.apple.com') }
  
  describe "open graph image fetch" do
    it 'successfully creates a background job' do
      ActiveJob::Base.queue_adapter = :test
      expect { FetchUrlOgImageJob.perform_later(page) }.to have_enqueued_job
    end    

    it 'successfully fetches an og image and marks the job as processed' do
      FetchUrlOgImageJob.perform_now(page)

      expect(page.og_image_url).to include("open_graph_logo")
      expect(page.processed).to be(true)
    end  
  end
end
