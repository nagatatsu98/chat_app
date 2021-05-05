require 'securerandom'

class GroupsController < ApplicationController
  before_action :require_user_logged_in, except: :show
  
  def show
    @group = Group.find_by(token: params[:token])
    @messages = @group.messages.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @group = current_user.groups.build
  end

  def create
    @group = current_user.groups.build(group_params)
    @group.token = SecureRandom.uuid
    if @group.save
      flash[:success] = 'グループを作成しました。'
      @group.add_subscriber(current_user)
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = 'グループを作成できませんでした。'
      render :new
    end
  end

  def edit
    @group = current_user.groups.find_by(token: params[:token])
  end

  def update
    @group = current_user.groups.find_by(token: params[:token])
    if @group.update(group_params)
      flash[:success] = 'グループ情報を更新しました。'
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = 'グループ情報を更新できませんでした。'
      render :new
    end
  end

  def destroy
    group = Group.find_by(token: params[:token])
    group.destroy if group
    flash[:success] = 'グループを削除しました。'
    redirect_to root_url
  end
  
  private
  
  def group_params
    params.require(:group).permit(:name, :description, :private, :image, :background_image)
  end
end
