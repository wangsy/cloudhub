class CreateCloudStorages < ActiveRecord::Migration[5.1]
  def change
    create_table :cloud_storages do |t|
      t.string :name
      t.string :access_token

      t.timestamps
    end
  end
end
