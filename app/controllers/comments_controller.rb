class CommentsController < ApplicationController
  before_filter :require_user, :except => [:show, :index]

  def index
    @wisdom = Wisdom.friendly.find(params[:wisdom_id])
    render :json => @wisdom.comments
  end

  def show
    @comment = Comment.friendly.find(params[:id])
    render :json => @comment
  end

  def create
    @wisdom = Wisdom.friendly.find(params[:wisdom_id])
    @comment = @wisdom.comments.create(params[:comment].permit(:body))
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @wisdom
    else
      redirect_to wisdom_path(@wisdom)
    end
  end

  def destroy
    @wisdom = Wisdom.friendly.find(params[:wisdom_id])
    @comment = @wisdom.comments.find(params[:id])
    @comment.destroy
    redirect_to wisdom_path(@wisdom)
  end

end
