class SubscribersController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @group = Group.find_by(token: params[:group_token])
    @group.add_subscriber(current_user)
    flash[:success] = '参加しました。'
    redirect_to group_path(token: @group.token)
  end

  def destroy
    @group = Group.find_by(token: params[:group_token])
    @group.remove_subscriber(current_user)
    flash[:success] = 'グループを抜けました。'
    redirect_to group_path(token: @group.token)
  end
end
