class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to (:back)
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      flash[:notice] = "Comment was removed"
      redirect_to :back
    else
      flash[:notice] = "There was an error removing comment"
      redirect_to :back
    end
  end 


private

  def comment_params
    params.require(:comment).permit(:text, :post_id, :user_id)
  end

end