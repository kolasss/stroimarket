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

    criterias = @category.product_attributes? ? set_criterias : {}

    @products = @category.products.where(criterias)
  end

  private
    # def set_category
    #   @category = Category.find(params[:id])
    #   authorize AdminController
    # end

    def set_criterias
      arr = {}
      @category.product_attributes.each do |pr_at|
        add_criteria(arr, pr_at) if @filter[pr_at.name].present?
      end
      return arr
    end

    def add_criteria arr, pr_at
      case pr_at.type
      when 'string'
        arr[pr_at.name.to_sym] = Regexp.new(".*"+@filter[pr_at.name]+".*")
      when 'boolean'
        @filter[pr_at.name] = @filter[pr_at.name].to_bool
        arr[pr_at.name.to_sym] = true if @filter[pr_at.name]
      when 'integer'
        minmax_criteria = {}

        set_integer_filter(:min, pr_at, minmax_criteria) if @filter[pr_at.name][:min].present?
        set_integer_filter(:max, pr_at, minmax_criteria) if @filter[pr_at.name][:max].present?

        arr[pr_at.name.to_sym] = minmax_criteria if minmax_criteria.present?
      end
    end

    def set_integer_filter symbol, pr_at, minmax_criteria
      @filter[pr_at.name][symbol] = @filter[pr_at.name][symbol].to_i
      limit = symbol == :min ? '$gte' : '$lte'
      minmax_criteria[limit] = @filter[pr_at.name][symbol]
    end

end
