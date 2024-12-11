class Users::FollowersController < ApplicationController
  before_action :set_followed

  def follow
    @followed.followers << current_user unless @followed.followers.include?(current_user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def unfollow
    @followed.followers.delete(current_user) if @followed.followers.include?(current_user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def set_followed
    @followed = User.find(params[:user_id])
  end
end
