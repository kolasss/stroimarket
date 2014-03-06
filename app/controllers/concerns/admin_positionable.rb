module AdminPositionable
  extend ActiveSupport::Concern

  included do
    before_action :set_class_name, only: [:update_position]
  end

  def update_position
    @object = @model_name.find(params[:id])
    authorize AdminController, :update?

    if params[:prev_id]
      @object.move_below(@model_name.find(params[:prev_id]))
    else
      @object.parent = params[:parent_id] ? @model_name.find(params[:parent_id]) : nil

      @object.save
      @object.move_to_top
    end

    render nothing: true
  end

  private
    def set_class_name
      @model_name = controller_name.classify.constantize
    end

end
