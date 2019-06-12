class FeedsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    subscribed_users_ids = current_user.following.ids
    @posts = Post.subscribed(subscribed_users_ids)
  end

  def public
    @q = Post.includes(:user).ransack(params[:q])
    @posts = @q.result.paginate(page: params[:page])
  end
end
