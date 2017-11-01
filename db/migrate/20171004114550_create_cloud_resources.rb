class CreateCloudResources < ActiveRecord::Migration[5.1]
  def change
    create_table :cloud_resources do |t|
      t.string :name
      t.string :path_lower
      t.string :path_display
      t.string :resource_id
      t.datetime :client_modified
      t.datetime :server_modified
      t.string :rev
      t.integer :size, limit: 8
      t.string :content_hash
      t.integer :parent_id
      t.string :resource_type

      t.timestamps
    end
  end
end
