class Event < ApplicationRecord
  belongs_to :host
  has_many :photos
  validates :title, presence: true
  validates :name, presence: true, uniqueness: true
  validates :description, length: {maximum: 30}
                                  #lengthの外カッコは要らないけど、maximumのカッコは省略不可
  validates :guest_password, {presence: true, length: {mininum: 6, maximum: 20}}
  #バリデーションは、アプリ側が一意性などを検証するもの。
  #直接DBに入れることはできてしまうので、セキュリティなどが脆弱になってしまう。
  #DBを作ったり、カラムを追加する時に、DB側にunique制約をつけてあげるとなおセーフ度があがる
end
