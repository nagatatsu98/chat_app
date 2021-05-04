class MessagesController < ApplicationController
  before_action :require_user_logged_in
  before_action :require_subscribe
  
  def create
    @group = Group.find_by(token: params[:group_token])
    @message = @group.messages.build(message_params)
    if @message.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to group_path(token: @group.token)
    else
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      @messages = @group.messages.order(created_at: :desc).page(params[:page]).per(10)
      render "groups/show"
    end
  end

  private
  
  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
  
  def require_subscribe
    group = Group.find_by(token: params[:group_token])
    unless group.subscriber?(current_user)
      redirect_to group_path(token: group.token) 
    end
  end
end
