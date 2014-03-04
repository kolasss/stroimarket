class CategoriesController < ApplicationController
  # before_action :set_category, only: [:show]

  def index
    @categories = Category.all
    authorize @categories
  end

  def show
    @category = Category.includes(:products).find(params[:id])
    authorize @category

    @filter = OpenStruct.new params[:filter]
    @filter.class_name = :filter
    @filter.symbol_name = :fields

    criterias = {}

    @category.product_attributes.each do |pr_at|
      case pr_at.type
      when 'string'
        criterias[pr_at.name.to_sym] = Regexp.new(".*"+@filter[pr_at.name]+".*")
      when 'boolean'
        @filter[pr_at.name] = @filter[pr_at.name].to_bool
        criterias[pr_at.name.to_sym] = true if @filter[pr_at.name]
      when 'integer'
        minmax_criteria = {}
        if @filter[pr_at.name][:min].present?
          @filter[pr_at.name][:min] = @filter[pr_at.name][:min].to_i
          minmax_criteria['$gte'] = @filter[pr_at.name][:min]
        end
        if @filter[pr_at.name][:max].present?
          @filter[pr_at.name][:max] = @filter[pr_at.name][:max].to_i
          minmax_criteria['$lte'] = @filter[pr_at.name][:max]
        end
        criterias[pr_at.name.to_sym] = minmax_criteria if minmax_criteria.present?
      end if @filter[pr_at.name].present?
    end if @category.product_attributes?

    @products = @category.products.where(criterias)
  end

  private
    # def set_category
    #   @category = Category.find(params[:id])
    #   authorize AdminController
    # end

end
