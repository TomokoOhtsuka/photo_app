class Photos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :photo #画像のpathが入る
      
      t.timestamps
    end
  end
end
