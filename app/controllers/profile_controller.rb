class ProfileController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    @wisdoms = Wisdom.where(:user_id => @user.id).page(params[:page]).order("created_at DESC")
    @comments = @user.comments
    respond_to do |format|
      format.html #show
      format.json { render :json => @wisdoms }
    end
  end
end
