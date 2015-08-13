class PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to (:back)
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "Post was removed"
      redirect_to :back
    else
      flash[:notice] = "There was an error removing the post"
      redirect_to :back
    end
  end 


private

  def post_params
    params.require(:post).permit(:text, :location_id, :user_id)
  end

end