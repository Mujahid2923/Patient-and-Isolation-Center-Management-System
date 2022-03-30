class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.page(params[:page]).per(5)
  end

  def show; end

  def new; end

  def destroy
    @user.destroy!
    flash[:notice] =
      I18n.t('notice.delete.success', resource: User.model_name.human, name: @user.name)
    redirect_to users_path
  end

  def dashboard
    @user_info = User.find(params[:user_id])
  end
end
