class CommentsController < ApplicationController

  def create
    @wisdom = Wisdom.find(params[:wisdom_id])
    @comment = @wisdom.comments.create(params[:comment].permit(:commenter, :body))
    redirect_to wisdom_path(@wisdom)
  end

  def destroy
    @wisdom = Wisdom.find(params[:wisdom_id])
    @comment = @wisdom.comments.find(params[:id])
    @comment.destroy
    redirect_to wisdom_path(@wisdom)
  end

end
