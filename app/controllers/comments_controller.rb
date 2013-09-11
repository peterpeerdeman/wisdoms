class CommentsController < ApplicationController
  before_filter :require_user, :except => [:show, :index]

  def index
    @wisdom = Wisdom.find(params[:wisdom_id])
    render :json => @wisdom.comments
  end

  def show
    @comment = Comment.find(params[:id])
    render :json => @comment
  end

  def create
    @wisdom = Wisdom.find(params[:wisdom_id])
    @comment = @wisdom.comments.create(params[:comment].permit(:commenter, :body))
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @wisdom
    else
      render 'new'
    end
  end

  def destroy
    @wisdom = Wisdom.find(params[:wisdom_id])
    @comment = @wisdom.comments.find(params[:id])
    @comment.destroy
    redirect_to wisdom_path(@wisdom)
  end

end
