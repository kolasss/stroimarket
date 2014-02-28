class OfferPolicy < ApplicationPolicy
  def permitted_attributes
    if user.admin?
      [:price, :user_id]
    else
      [:price]
    end
  end

  def create?
    user.admin? or (user.seller? and record.product.offers.where(:user_id => user.id).empty?)
  end

  def update?
    user.admin? or record.user == user
  end

  def destroy?
    update?
  end
end
