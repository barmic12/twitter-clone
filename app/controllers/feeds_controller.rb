class FeedsController < ApplicationController
  before_action :authenticate_user!
  def index
    subscribed_users_ids = current_user.following.ids
    @posts = Post.subscribed(subscribed_users_ids)
  end
end
