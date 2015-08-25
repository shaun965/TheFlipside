class HomeController < ApplicationController

def index
  if !current_user
    redirect_to new_user_session_path
  else
    @historys = current_user.historys.sort_by(&:created_at)
    @posts = current_user.posts.sort_by(&:created_at)
  end
end

end