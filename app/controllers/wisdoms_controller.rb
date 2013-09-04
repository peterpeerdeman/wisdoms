class WisdomsController < ApplicationController

  def index
    @wisdoms = Wisdom.all
  end

  def show
    @wisdom = Wisdom.find(params[:id])
  end

  def new
  end

  def create
    @wisdom = Wisdom.new(wisdom_params)
    @wisdom.save
    redirect_to @wisdom
  end

  private
  def wisdom_params
    params.require(:wisdom).permit(:quote, :author)
  end

end
