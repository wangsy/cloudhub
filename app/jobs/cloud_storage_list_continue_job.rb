class CloudStorageListContinueJob < ApplicationJob
  queue_as :default

  def perform(*cloud_storages)
    # Do something later
    cloud_storages.each do |cloud_storage|
      client = DropboxApi::Client.new(cloud_storage.access_token)
      result = client.list_folder_continue(cloud_storage.last_cursor)
      cloud_storage.update(last_cursor: result.cursor)
      result.entries.each do |entry|
        CloudResource.from_entry entry
      end
    end
  end
end
