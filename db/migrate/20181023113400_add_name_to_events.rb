class AddNameToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :name, :string, unique: true, null: false, default: "url"
    #tutorial リスト6.28：DBにunique制約をもたせる(バリデーションより強固)
    #not null制約(nullはダメだよ、nullの場合はデフォルト入れようねっていう)をもたせる
      #→https://www.rubylife.jp/rails/model/index9.html
    #すでにあるカラムに対し、後からchange_column_nullでnot null制約をもたせる
      #→https://ver-1-0.net/2018/03/01/rails-migration-not-null/
    add_index :events, :name　#eventsテーブルのnameカラムにインデックスを付与してる。
    
  end
end
=begin
インデックスを簡単に言うと対象のカラムのデータを取り出し、
高速に検索できるように手を加えて保存しておいたものです。
データを検索する時にテーブルではなくインデックスの方を検索しますので
非常に高速に検索ができる場合があります。
インデックスには、1とか2とかの数値といった、コンソールで呼び出せるような具体的な何かが与えられるわけではなく、
単純にDBを探しやすくするようにrails側が裏？で手を加えてくれているイメージ。
=end