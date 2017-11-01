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
        CloudResource.create!(
          name:entry.name,
          path_lower:entry.path_lower,
          path_display:entry.path_display,
          resource_id: entry.id,
          parent_id: parent.id,
          resource_type: "folder")
      elsif entry.class == DropboxApi::Metadata::File
        CloudResource.create!(
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
  end

  def self.find_root
    CloudResource.where(parent_id: nil).first
  end

  def children
    CloudResource.where(parent_id: self.id)
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
end
