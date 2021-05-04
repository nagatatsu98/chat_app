require 'securerandom'

class GroupsController < ApplicationController
  def show
    @group = Group.find_by(token: params[:token])
  end

  def new
    @group = current_user.groups.build
  end

  def create
    @group = current_user.groups.build(group_params)
    @group.token = SecureRandom.uuid
    if @group.save
      flash[:success] = 'グループを作成しました。'
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = 'グループを作成できませんでした。'
      render :new
    end
        
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  
  def group_params
    params.require(:group).permit(:name, :description, :private, :image, :background_image)
  end
end
