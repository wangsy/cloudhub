class CloudResource < ApplicationRecord
  def self.find_or_create_parent (path_lower)
    parent_path_lower = path_lower.split("/")[0...-1].join("/")
    cResource = CloudResource.find_by_path_lower parent_path_lower
    if cResource.present?
      return cResource
    else
      return CloudResource.create! path_lower: parent_path_lower, resource_type: "folder"
    end
  end

  def self.from_entry (entry)
    cResource = CloudResource.find_by_path_lower entry.path_lower
    parent = CloudResource.find_or_create_parent entry.path_lower
    if cResource.present?
      if entry.class == DropboxApi::Metadata::Folder
        cResource.update(
          name:entry.name,
          path_lower:entry.path_lower,
          path_display:entry.path_display,
          resource_id: entry.id,
          parent_id: parent.id,
          resource_type: "folder")
      elsif entry.class == DropboxApi::Metadata::File
        cResource.update(
          name:entry.name,
          path_lower:entry.path_lower,
          path_display:entry.path_display,
          resource_id: entry.id,
          client_modified: entry.client_modified,
          server_modified: entry.server_modified,
          rev: entry.rev,
          size: entry.size,
          content_hash: entry.content_hash,
          parent_id: parent.id,
          resource_type: "file")
      end
    else
      if entry.class == DropboxApi::Metadata::Folder
        cResource = CloudResource.create!(
          name:entry.name,
          path_lower:entry.path_lower,
          path_display:entry.path_display,
          resource_id: entry.id,
          parent_id: parent.id,
          resource_type: "folder")
      elsif entry.class == DropboxApi::Metadata::File
        cResource = CloudResource.create!(
          name:entry.name,
          path_lower:entry.path_lower,
          path_display:entry.path_display,
          resource_id: entry.id,
          client_modified: entry.client_modified,
          server_modified: entry.server_modified,
          rev: entry.rev,
          size: entry.size,
          content_hash: entry.content_hash,
          parent_id: parent.id,
          resource_type: "file")
      end
    end
    cResource
  end

  def self.find_root
    CloudResource.where(parent_id: nil).first
  end

  def children(page)
    CloudResource.where(parent_id: self.id).paginate(page: page, per_page: 100)
  end

  def parents
    parents = []
    node = self
    while node.parent_id.present?
      parent = CloudResource.find(node.parent_id)
      parents.unshift parent
      node = parent
    end
    parents
  end

  def image?
    ext = name.downcase
    return true if ext.end_with? "jpeg" or ext.end_with? "jpg" or
      ext.end_with? "tiff" or ext.end_with? "tif" or
      ext.end_with? "bmp" or ext.end_with? "png"
    false
  end

  def thumbnail_path
    return nil unless image?
    path = "#{Rails.root}/public/cloud_resources/#{id}/thumbnail.jpg"
    return "/cloud_resources/#{id}/thumbnail.jpg" if File.exist? path
    CloudResourceDownloadThumbnailJob.perform_later self
    nil
  end

  def download_thumbnail
    if image?
      dropbox = CloudStorage.first
      client = DropboxApi::Client.new(dropbox.access_token)
      dir = "#{Rails.root}/public/cloud_resources/#{id}/"
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      file = File.open("#{Rails.root}/public/cloud_resources/#{id}/thumbnail.jpg", "wb")

      client.get_thumbnail(resource_id, :format => :jpeg, size: "w1024h768") do |thumbnail_content|
        file.write thumbnail_content
      end
      file.close
    end
  end
end
