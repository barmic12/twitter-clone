class FeedsController < ApplicationController
  before_action :authenticate_user!
  def index
    subscribed_users_ids = current_user.following.ids
    @posts = Post.subscribed(subscribed_users_ids)
  end

  def tag
    @tag_name = params[:tag_name]
    @tagged_posts = Post.with_all_tags(@tag_name).limit(10)
    @post_tags_cloud = Post.where('tag like ?', @tag_name).tags_cloud
    @number_of_tagged_posts = if @post_tags_cloud.present?
                                @post_tags_cloud[0][1]
                              else
                                0
                              end
  end
end
