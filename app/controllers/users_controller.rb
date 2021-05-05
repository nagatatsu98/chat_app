class UsersController < ApplicationController
  before_action :correct_user, except: [:index, :show, :new, :create]
  
  def index
    search_key = params[:q]
    if search_key
      @users = User.where('name like ?', "%#{search_key}%")
    else
      @users = User.all
    end
  end
  
  def show
    @user = User.find(params[:id])
    @access = params[:access]
    if @access == 'private'
      @groups = @user.groups.where(private: true)
    else
      @groups = @user.groups.where(private: false)
      @access = 'public'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to root_path
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:success] = 'ユーザ情報を更新しました。'
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = 'ユーザ情報の更新に失敗しました。'
      render :edit
    end
  end
  
  def password
    @user = User.find(params[:id])
  end
  
  def update_password
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:success] = 'パスワードを更新しました。'
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = 'パスワードの更新に失敗しました。'
      render :password
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :id, :image)
  end
  
  def correct_user
    unless current_user == User.find_by(id: params[:id])
      redirect_to root_path
    end
  end
end
