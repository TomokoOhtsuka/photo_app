class AddNameToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :name, :string, unique: true, null: false, default: "url"
      #tutorial リスト6.28：DBにunique制約をもたせる(バリデーションより強固)
      #not null制約(nullはダメだよ、nullの場合はデフォルト入れようねっていう)をもたせる
        #→https://www.rubylife.jp/rails/model/index9.html
      #すでにあるカラムに対し、後からchange_column_nullでnot null制約をもたせる
        #→https://ver-1-0.net/2018/03/01/rails-migration-not-null/
  end
end