class Ckeditor::AttachmentFilePolicy
  attr_reader :user, :attachment

  def initialize(user, attachment)
    @user = user
    @attachment = attachment
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
    # @attachment.assetable_id == @user.id
    @user.admin?
  end
end
