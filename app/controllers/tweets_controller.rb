class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :retweet, :like, :unlike]

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all.paginate(:page => params[:page], :per_page => 20)
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
    @hashtags = SimpleHashtag::Hashtag.order('created_at DESC').limit(10)
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = current_user.tweets.new(tweet_params)
    # @tweet = Tweet.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to :back, notice: 'Your Post Has Been Created.' }
        format.js
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Post Deleted.' }
      format.js
      format.json { head :no_content }
    end
  end

  def retweet
    tweet = current_user.tweets.new(tweet_id: @tweet.id)
    if tweet.save
      redirect_to root_path
    else
      redirect_to :back, alert: "Unable to retweet"
    end
  end

  def like
     if @tweet.liked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end
  
  def unlike
    @tweet.unliked_by current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:body, :tweet_id, :user_id, :media)
    end
end
