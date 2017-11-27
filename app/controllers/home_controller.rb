class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
  	# @tweets = Tweet.order('created_at DESC')
  	# @tweet = current_user.tweets.build if signed_in?
    @feed_items = current_user.feed.order('created_at DESC')
    # next two lines are fake AF
    @post_paginator = Tweet.paginate(page: params[:page], per_page: 2).order(created_at: :desc)	
	  @post = @post_paginator.group_by { |r| r.created_at.to_date }

    @suggestions = User.where.not(id: @current_user).order('RANDOM()').limit(3)
    @tweet = Tweet.new

  	@hashtags = SimpleHashtag::Hashtag.order('created_at DESC').limit(10)
  end
end
