class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :destroy, :update]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page],
      per_page: Settings.per_page)
  end

  def show
    @microposts = @user.microposts.created_at_desc.paginate(page:
      params[:page], per_page: Settings.per_page)
    @follow = current_user.active_relationships.build
    @unfollow = current_user.active_relationships.find_by(followed_id: @user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".delete"
      redirect_to users_path
    else
      flash[:danger] = t ".fail_delete"
      redirect_to root_path
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t ".update"
      redirect_to @user
    else
      flash[:danger] = t ".can_not_find_user"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation, :gender, :date_of_birth)
  end

  def correct_user
    redirect_to root_url unless current_user.current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t ".can_not_find_user"
    redirect_to root_url
  end
end
