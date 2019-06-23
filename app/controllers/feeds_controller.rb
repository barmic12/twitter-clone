class FeedsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    subscribed_users_ids = current_user.following.ids
    @posts = Post.subscribed(subscribed_users_ids)
  end

  def public
    @q = Post.includes(:user).ransack(params[:q])
    @posts = @q.result.paginate(page: params[:page])
    # Following queries without where are really time-consuming
    # @comments_by_post = Comment.group(:post_id).count
    # @likes_by_post = @posts.joins(:likes).group('likes.likeable_id').count

    @comments_by_post = Comment.where(post_id: @posts.ids).group(:post_id).count
    @likes_by_post = @posts.where(id: @posts.ids).joins(:likes).group('likes.likeable_id').count

    fresh_when @posts
  end
end
