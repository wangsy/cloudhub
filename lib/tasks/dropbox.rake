namespace :dropbox do
  desc ">>List Folders"
  task :list_folders => :environment do |task, args|
    dropbox = CloudStorage.first
    client = DropboxApi::Client.new(dropbox.access_token)
    result = client.list_folder "", {recursive: true}
    dropbox.update(last_cursor: result.cursor)
    result.entries.each do |entry|
      CloudResource.from_entry entry
    end
    while result.has_more?
      result = client.list_folder_continue(result.cursor)
      dropbox.update(last_cursor: result.cursor)
      result.entries.each do |entry|
        CloudResource.from_entry entry
      end
    end
  end
end

# #<DropboxApi::Metadata::Folder:0x00007fcd14456d50
#   @name="제안서",
#   @path_lower="/보고서 정리/4_입찰도전/12.농산물/제안서",
#   @path_display="/보고서 정리/4_입찰도전/12.농산물/제안서",
#   @id="id:7Oo4uOAn6ksAAAAAAAACFg",
#   @sharing_info=#<DropboxApi::Metadata::FolderSharingInfo:0x00007fcd14456a80 @read_only=false, @parent_shared_folder_id="692086136", @shared_folder_id=nil>>
# #<DropboxApi::Metadata::File:0x00007fcd14484890
#   @name="board_temperature_red.png",
#   @path_lower="/project-hypnos/png_xxxhdpi(x4)/board_temperature_red.png",
#   @path_display="/Project-Hypnos/PNG_xxxhdpi(x4)/board_temperature_red.png",
#   @id="id:Mdia0NbI2OAAAAAAAAAA8g",
#   @client_modified=2015-05-15 06:31:26 UTC,
#   @server_modified=2015-06-03 08:37:29 UTC,
#   @rev="2953700f2a9",
#   @size=13138,
#   @content_hash="dd8f4250113e88aff97c633e105a538d65df1c669cdac1dd3ded8e4d0f551d99",
#   @media_info=nil>
