class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find_by id: params[:followed_id]
    check_valid user
    current_user.follow user
    redirect_to user
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    check_valid user
    current_user.unfollow user
    redirect_to user
  end

  private

  def check_valid object
    return if object
    flash[:danger] = t "can_not_find"
    redirect_to current_user
  end
end
