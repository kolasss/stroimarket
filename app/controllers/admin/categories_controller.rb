class Admin::CategoriesController < AdminController
  include AdminPositionable

  private
    def object_params
      safe_attributes = [
        :title,
        :position,
        :parent_id,
        product_attributes_attributes:
        [
          :id,
          :_destroy,
          :title,
          :type,
          :unit
        ]
      ]
      params.require(:category).permit(*safe_attributes)
    end
end
