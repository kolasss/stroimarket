class Admin::StoreProfilesController < AdminController
  before_action :set_user, except: [ :index ]
  before_action :set_profile, only: [ :edit, :update, :destroy ]

  def index
    @all_profiles = User.sellers.map(&:store_profile).compact
    @store_profiles = Kaminari.paginate_array(@all_profiles).page(params[:page])
    authorize StoreProfile
  end

  # def show
  # end

  def new
    @user.build_store_profile
    authorize @user.store_profile
  end

  def edit
  end

  def create
    @store_profile = @user.build_store_profile(profile_params)
    authorize @store_profile

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

    redirect_to admin_store_profiles_path
  end

  protected
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_profile
      @store_profile = @user.store_profile
      authorize @store_profile
    end

    def profile_params
      params.require(:store_profile).permit(
        :name,
        :title,
        :ogrn,
        :address,
        :phone
      )
    end

end
