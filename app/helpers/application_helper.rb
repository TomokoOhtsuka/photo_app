module ApplicationHelper
  def full_title(page_title=" ")#デフォルトは空だよ(タイトルが空のものがあっても良いよ)、という意味
    #ここで引数で空の文字列を渡しておかないと、下のif文の中でｅｍｐｔｙにならず、nilになってしまう
    #引数があるとその引数の値をセットし、省略するとデフォルト引数でセットされた値を返す
    base_title = "Something Blue"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
