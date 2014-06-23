class UserPolicy < AdminControllerPolicy
  def show?
    @user.admin? or @record == @user
  end

  def create?
    @user.admin?
  end

  def update?
    show?
  end
end
