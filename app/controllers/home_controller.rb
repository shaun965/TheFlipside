class HomeController < ApplicationController

def index
  if !current_user
    redirect_to new_user_session_path
  else
    @historys = current_user.historys
    @posts = current_user.posts
  end
end

end