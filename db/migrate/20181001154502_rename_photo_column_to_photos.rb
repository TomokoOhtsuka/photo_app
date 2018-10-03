class RenamePhotoColumnToPhotos < ActiveRecord::Migration[5.2]
  def change
    rename_column :photos, :photo, :image
                #テーブル名　元のカラム名　変更後のカラム名
  end
end
