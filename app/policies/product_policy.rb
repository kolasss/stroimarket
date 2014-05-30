class ProductPolicy < ApplicationPolicy
  def create?
    @user.seller?
  end

  def update?
    @user.seller?
  end

  def destroy?
    @user.seller?
  end
end
