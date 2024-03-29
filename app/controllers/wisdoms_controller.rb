class WisdomsController < ApplicationController
  before_filter :require_user, :except => [:show, :index]

  def index
    @wisdoms = Wisdom.friendly.page(params[:page]).order("created_at DESC")
    respond_to do |format|
      format.html #show
      format.js #show js template
      format.json { 
        render :json => {
          :current_page => @wisdoms.current_page,
          :per_page => @wisdoms.per_page,
          :total_entries => @wisdoms.total_entries,
          :entries => @wisdoms
        }
      }
    end
  end

  def show
    @wisdom = Wisdom.friendly.find(params[:id])
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
    @wisdom.user_id = current_user.id
    if @wisdom.save
      checkAndShareToFacebook(@wisdom, wisdom_params[:share_to_facebook])
      redirect_to @wisdom
    else
      render 'new'
    end
  end

  def update
    @wisdom = Wisdom.friendly.find(params[:id])
    if @wisdom.update(params[:wisdom].permit(:quote, :author))
      redirect_to @wisdom
    else
      render 'edit'
    end
  end

  def destroy
    @wisdom = Wisdom.friendly.find(params[:id])
    @wisdom.destroy
    redirect_to wisdoms_path
  end

  def edit
    @wisdom = Wisdom.friendly.find(params[:id])
  end

  private
  def wisdom_params
    params.require(:wisdom).permit(:quote, :author, :share_to_facebook)
  end

  def checkAndShareToFacebook(wisdom, shareCheckbox) 
    if shareCheckbox == '1'
      @graph = Koala::Facebook::API.new(current_user.oauth_token)
      begin
        Thread.new {
          @result = @graph.put_connections('me', 'og.posts', :object => URI.join(request.original_url,url_for(wisdom)))
          logger.debug @result.inspect
        }
      rescue Koala::Facebook::ClientError => e
        logger.debug '///exception while trying to post to facebook'
        logger.debug e.message
        logger.debug e.fb_error_message
        logger.debug '///'
        return
      end
    end
  end
end
