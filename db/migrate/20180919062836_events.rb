class Events < ActiveRecord::Migration[5.2]
  
  def change
    create_table :events do |t|
      t.string :title
      t.integer :host_id
      t.text :description
      
      t.timestamps
    end
  end
end