class WisdomsController < ApplicationController

  def index
    @wisdoms = Wisdom.all
  end

  def show
    @wisdom = Wisdom.find(params[:id])
    respond_to do |format|
      format.html #show
      format.json { render :json => @wisdom }
    end
  end

  def new
    @wisdom = Wisdom.new
  end

  def create
    @wisdom = Wisdom.new(wisdom_params)
    if @wisdom.save
      redirect_to @wisdom
    else
      render 'new'
    end
  end

  def update
    @wisdom = Wisdom.find(params[:id])
    if @wisdom.update(params[:wisdom].permit(:quote, :author))
      redirect_to @wisdom
    else
      render 'edit'
    end
  end

  def destroy
    @wisdom = Wisdom.find(params[:id])
    @wisdom.destroy
    redirect_to wisdoms_path
  end

  def edit
    @wisdom = Wisdom.find(params[:id])
  end

  private
  def wisdom_params
    params.require(:wisdom).permit(:quote, :author)
  end

end
