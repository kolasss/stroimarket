class Admin::ArticlesController < AdminController
  include AdminPositionable

  private
    def object_params
      safe_attributes = [
        :title,
        :intro,
        :body,
        :cover,
        :remove_cover,
        :menu_title,
        documents_attributes: [
          :id,
          :title,
          :file,
          :_destroy
        ],
        images_attributes: [
          :id,
          :title,
          :file,
          :_destroy
        ]
      ]
      params.require(:article).permit(*safe_attributes)
    end
end
