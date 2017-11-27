class UsersController < ApplicationController

  before_action :check_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :following, :followers, :photos]
  # before_action :set_user, except: [:index]

  def index
    @users = User.where.not(id: @current_user).order('RANDOM()').limit(100)
    @suggestions = User.where.not(id: @current_user).order('RANDOM()').limit(3)
    @hashtags = SimpleHashtag::Hashtag.order('created_at DESC').limit(10)

    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order("created_at DESC")
    end
  end

 

  def show
    @user = User.friendly.find(params[:id]) 
    @tweets = @user.tweets.order('created_at DESC')
    @suggestions = User.where.not(id: @current_user).order('RANDOM()').limit(3)
  end

  def verified
    @user.toggle!(:verified)
  end

  def photos
    @user = User.find(params[:id])
    @tweets = @user.tweets.order('created_at DESC')
  end

  def mentions
    respond_to do |format|
      format.json { render :json => Mention.all(params[:q]) }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to :back, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user.update(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def destroy
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :password,  :about, :location, :website, :avatar, :cover, :verified)
  end

  def check_user
    if @user != current_user
      redirect_to root_path
    end
  end

  # def set_user
    # @user = User.friendly.find(params[:id])
    #according to friendly id the params shoulg be id not username
    # @user = User.friendly.find(params[:username])
  # end

end
