module AdminPositionable
  extend ActiveSupport::Concern

  included do
    before_action :set_class_name
    before_action :set_object, only: [:show, :edit, :update, :destroy]
  end

  def index
    instance_variable_set("@#{@variable_name.pluralize}", @model_name.all)
    authorize AdminController
  end

  def show
  end

  def new
    instance_variable_set("@#{@variable_name}", @model_name.new)
    authorize AdminController
  end

  def edit
  end

  def create
    instance_variable_set("@#{@variable_name}", @model_name.new(object_params))
    authorize AdminController

    @object = instance_variable_get("@#{@variable_name}")

    if @object.save
      redirect_to polymorphic_path([:admin, @object]), notice: t(:created)
    else
      render action: 'new'
    end
  end

  def update
    @object = instance_variable_get("@#{@variable_name}")

    if @object.update(object_params)
      redirect_to polymorphic_path([:admin, @object]), notice: t(:updated)
    else
      render action: 'edit'
    end
  end

  def destroy
    @object = instance_variable_get("@#{@variable_name}")

    @object.destroy
    redirect_to polymorphic_path([:admin, @model_name])
  end

  def update_position
    @object = instance_variable_set("@#{@variable_name}", @model_name.find(params[:id]))
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
    def set_object
      instance_variable_set("@#{@variable_name}", @model_name.find(params[:id]))
      authorize AdminController
    end

    def set_class_name
      @variable_name = controller_name.classify.downcase
      @model_name = controller_name.classify.constantize
    end

end
