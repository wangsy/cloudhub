json.extract! cloud_resource, :id, :name, :path_lower, :path_display, :resource_id, :client_modified, :server_modified, :rev, :size, :content_hash, :parent_id, :resource_type, :created_at, :updated_at
json.url cloud_resource_url(cloud_resource, format: :json)
