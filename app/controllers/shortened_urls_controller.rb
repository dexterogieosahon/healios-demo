class ShortenedUrlsController < ApplicationController
  before_action :set_user, only: [:new, :create]

  # GET /shortened_urls/1
  def show
    redirect_to ShortenedUrl.url_for(params[:id]), status: :moved_permanently
  end

  # GET /shortened_urls/new
  def new
    @shortened_url = @user.shortened_urls.build
  end

  # POST /shortened_urls
  def create
    @shortened_url = @user.shortened_urls.new(shortened_url_params)
    if @shortened_url.valid?
      @shortened_url = ShortenedUrl.generate(@shortened_url)
      redirect_to user_path(@user), notice: 'Shortened url was successfully created.'
    else
      render :new
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def shortened_url_params
      params.require(:shortened_url).permit(:url)
    end
end
