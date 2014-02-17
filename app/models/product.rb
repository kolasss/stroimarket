class Product
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :title, type: String
  field :cover, type: String
  field :body, type: String

  belongs_to :category

  before_validation :custom_field_to_datatype
  before_save :clear_old_custom_fields

  validates :title, :presence => true
  validates :body, :presence => true
  validates :category_id, :presence => true
  validate :custom_fields_validator

  private
    def custom_field_to_datatype
      self.category.product_attributes.each do |pr_at|
        name = pr_at.name.to_sym
        if pr_at.type == 'boolean'
          self[name] = self[name].to_bool
        elsif pr_at.type == 'integer'
          self[name] = self[name].to_i
        end
      end
    end

    def custom_fields_validator
      max_length = 30
      max_integer = 9223372036854775807
      min_integer = -9223372036854775807

      self.category.product_attributes.each do |pr_at|
        name = pr_at.name.to_sym
        if pr_at.type == 'string'
          errors.add(name, "Длина строки должна быть не больше #{max_length} символов") if self[name].length > max_length
        elsif pr_at.type == 'boolean'
          # errors.add(name, 'Неверное значение') unless [true, false].include?(self[name])
        elsif pr_at.type == 'integer'
          if self[name] > max_integer
            errors.add(name, "Значение должно быть не больше #{max_integer}")
          elsif self[name] < min_integer
            errors.add(name, "Значение должно быть не меньше #{min_integer}")
          end
        else
          raise NotImplementedError
        end
      end
    end

    def clear_old_custom_fields
      current = category.product_attributes.map(&:name)
      old = []
      dynamic_attributes.each do |dyn_at|
        old << dyn_at unless current.include?(dyn_at)
      end
      unset(old)
    end

    def dynamic_attributes
      attributes.keys - fields.keys
    end
end
