class StoreProfilePolicy < ApplicationPolicy
  # def index?
  #   user.admin?
  # end

  # def show?
  #   user.admin?
  # end

  def create?
    @user.admin? or @user.seller?
  end

  def update?
    @user.admin? or (@user.seller? and @record.user == @user)
  end
end
