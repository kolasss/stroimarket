class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :clean_password, only: [ :update ]

  def index
    @users = User.page(params[:page])
    authorize AdminController
  end

  def show
  end

  def new
    @user = User.new
    authorize AdminController
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    authorize AdminController
    # @user.skip_confirmation!

    if @user.save
      redirect_to admin_user_path(@user)
    else
      render :new, alert: t(:create_failed)
    end
  end

  def update
    # @user.skip_reconfirmation!

    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit, alert: t(:update_failed)
    end
  end

  def destroy
    @user.destroy

    redirect_to admin_users_path
  end

  protected

    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :role,
        :password,
        :password_confirmation,
      )
    end

    # def sorting_columns
    #   %w[name role created_at]
    # end

    def set_user
      @user = User.find(params[:id])
      authorize AdminController
    end

    def clean_password
      par = params[:user]

      if par[:password].blank?
        par.delete :password
        par.delete :password_confirmation
      end
    end
end
