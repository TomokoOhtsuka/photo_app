module SessionsHelper
  
 def log_in(host)
  #ログインする(誰を？)
  session[:host_id] = host.id
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
 end
 
end
