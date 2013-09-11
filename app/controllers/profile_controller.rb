class ProfileController < ApplicationController
  def show
    @user = User.find(params[:id])
    @wisdoms = @user.wisdoms
    @comments = @user.comments
    respond_to do |format|
      format.html #show
    end
  end
end
