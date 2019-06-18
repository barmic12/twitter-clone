class FeedsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    subscribed_users_ids = current_user.following.ids
    @posts = Post.subscribed(subscribed_users_ids)
  end

  def public
    @q = Post.includes(:user).ransack(params[:q])
    @posts = @q.result.paginate(page: params[:page])

    @posts_arr = Rails.cache.fetch('public_posts') do
      @posts.to_a
    end

    @comments_by_post = Rails.cache.fetch('comments_by_post') do
      Comment.where(post_id: @posts.ids).group(:post_id).count
    end

    @likes_by_post = Rails.cache.fetch('likes_by_post') do
      @posts.where(id: @posts.ids).joins(:likes).group('likes.likeable_id').count
    end
  end
end
