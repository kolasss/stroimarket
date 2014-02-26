class Admin::StoreProfilesController < AdminController
  # authorize_resource
  # skip_load_resource :only => [:index, :new, :create]
  # before_action :load_user, except: [ :index ]
  before_action :set_profile, only: [ :edit, :update, :destroy ]


  def index
    @users = User.sellers
    @store_profiles = @users
  end

  # def show
  # end

  def new
    # @user = User.find(params[:user_id])
    @user.build_store_profile
  end

  # def edit
  #   p "==========================================="
  #   # @user = User.find(params[:user_id])
  #   # @store_profile = @user.store_profile
  # end

  def create
    # @user = User.find(params[:user_id])
    # @store_profile = @user.store_profile.build(profile_params)
    # @store_profile = @user.build_store_profile(profile_params)

    if @store_profile.save
      redirect_to admin_user_path(@user)
    else
      render :new, alert: t(:create_failed)
    end
  end

  def update
    if @store_profile.update_attributes(profile_params)
      redirect_to admin_user_path(@user)
    else
      render :edit, alert: t(:update_failed)
    end
  end

  def destroy
    @store_profile.destroy

    redirect_to admin_user_path(@user)
  end

  protected
    def load_user
      @user = User.find(params[:user_id])
    end

    def set_profile
      @store_profile = @post.store_profile
    end

    # def profile_params
    #   params.require(:store_profile).permit(
    #     :name,
    #     :title,
    #     :ogrn,
    #     :address,
    #     :phone
    #   )
    # end

end
