class ProductPolicy < ApplicationPolicy
  def create?
    @user.seller? or @user.admin?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
