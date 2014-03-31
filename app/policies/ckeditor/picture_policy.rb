class Ckeditor::PicturePolicy
  attr_reader :user, :picture

  def initialize(user, picture)
    @user = user
    @picture = picture
  end

  def index?
    # true and ! @user.nil?
    @user.admin?
  end

  def create?
    # true and ! @user.nil?
    @user.admin?
  end

  def destroy?
    # @picture.assetable_id == @user.id
    @user.admin?
  end
end
