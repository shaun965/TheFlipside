class PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to (:back)
  end


private

  def post_params
    params.require(:post).permit(:text, :location_id, :user_id)
  end

end