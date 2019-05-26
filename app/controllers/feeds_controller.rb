class FeedsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    subscribed_users_ids = current_user.following.ids
    @posts = Post.subscribed(subscribed_users_ids)
  end

  def tag
    @tag_name = params[:tag_name]
    @number_of_tagged_posts = ActsAsTaggableOn::Tag.find_by(name: @tag_name).taggings_count
    @tagged_posts = Post.tagged_with(@tag_name).limit(10)
  end
end
