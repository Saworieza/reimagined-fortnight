class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  def index
  	@activities = PublicActivity::Activity.order("created_at DESC").where(owner_id: current_user.following_ids, owner_type: "User")
  	@suggestions = User.where.not(id: @current_user).order('RANDOM()').limit(3)
  	@hashtags = SimpleHashtag::Hashtag.order('created_at DESC')
  end
end
