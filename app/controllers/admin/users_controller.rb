class Admin::UsersController < Admin::BaseController
  def index
    @user_all = User.order(created_at: :desc).all
    @users = User.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @user = load_user

    @orders = @user.orders.order(created_at: :desc)
  end

  def destroy
    @user = load_user

    @user.destroy

    redirect_to admin_users_path, notice: 'Дані видалено'
  end

  private

  def load_user
    User.find(params[:id])
  end
end