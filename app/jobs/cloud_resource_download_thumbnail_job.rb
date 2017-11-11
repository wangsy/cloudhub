class CloudResourceDownloadThumbnailJob < ApplicationJob
  queue_as :default

  def perform(*cloud_resources)
    cloud_resources.each do |cloud_resource|
      cloud_resource.download_thumbnail
    end
  end
end
