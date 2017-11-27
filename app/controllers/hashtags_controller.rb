class HashtagsController < ApplicationController

  def index
    @hashtags = SimpleHashtag::Hashtag.order('created_at DESC')
  end

  def show
  	@hashtags = SimpleHashtag::Hashtag.order('created_at DESC').limit(10)
  	
    @hashtag = SimpleHashtag::Hashtag.find_by_name(params[:hashtag])
    @hashtagged = @hashtag.hashtaggables if @hashtag
  end

end
