class MentionsController < ApplicationController
	def users
        render json: User.all, root: false
    end
end
