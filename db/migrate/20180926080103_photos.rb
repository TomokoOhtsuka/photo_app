class Photos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :photo #画像のpathが入る
      #※rename_photo_column_to_photos.rbでカラム名をimageに変更※
      t.timestamps
    end
  end
end
