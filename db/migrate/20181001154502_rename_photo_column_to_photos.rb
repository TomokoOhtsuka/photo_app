class RenamePhotoColumnToPhotos < ActiveRecord::Migration[5.2]
  def change
    rename_column :photos, :photo, :image
  end
end
