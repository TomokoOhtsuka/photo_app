module SessionsHelper
  
 def log_in(host)
  #ログインする(誰を？を引数で入れてあげる)
  session[:host_id] = host.id
  #↓hostとしてログインするならguestとしてはログアウトする
   #(必須の動作ではないけど、ゲスト側の動作確認のため)
  if guest_logged_in?
   session[:guest_password] = nil
  end
 end
 
 def current_host
  #今のhost＝今いるhostだから、引数で「誰を」と補ってあげる必要なし
  if session[:host_id]
   @current_host ||= Host.find_by(id: session[:host_id])
  end
 end
 
 def logged_in?
  !current_host.nil?
 end
 
 def log_out
  session.delete(:host_id)
  @current_host = nil
 end
 
 def store_location
    session[:forwarding_url] = request.original_url if request.get?
    #もしも、現在のrequestがGETなら(POSTやDELETEなどじゃなくてGETなら)、
    #今の(ログインページに連れて行かれる前に閲覧していた)URLをセッションに代入する
 end
 
end
