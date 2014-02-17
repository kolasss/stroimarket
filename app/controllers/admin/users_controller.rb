class Admin::UsersController < AdminController
  load_and_authorize_resource
  skip_load_resource :only => [:index, :create]
  # include Concerns::SortableController

  # before_action :require_admin_rights!

  # before_action :set_user,     except: [ :index, :new, :create ]
  before_action :clean_password, only: [ :update ]

  def index
    @users = User.page(params[:page])
  end

  def show
  end

  def new
    # @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
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

  # def set_user
  #   @user = User.find(params[:id])
  # end

    def clean_password
      par = params[:user]

      if par[:password].blank?
        par.delete :password
        par.delete :password_confirmation
      end
    end
end
