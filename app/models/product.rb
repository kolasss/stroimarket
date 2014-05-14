class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Mongoid::Attributes::Dynamic
  include Content
  include Mongoid::Search

  belongs_to :category
  belongs_to :manufacturer
  has_many :offers, dependent: :destroy

  field :min_price, type: Integer
  field :max_price, type: Integer
  field :views, type: Integer, default: 0

  # Часть для кастомных полей
  # before_validation :custom_field_to_datatype
  # before_save :clear_old_custom_fields, if: :category_id_changed?
  # validate :custom_fields_validator

  validates :category_id, :presence => true

  search_in :title

  def has_user_offer? user
    self.offers.map(&:user_id).include?(user.id)
  end

  def user_offer user
    self.offers.where(user_id: user.id)
  end

  def set_min_max_price
    update_attribute(:min_price, offers.min(:price))
    update_attribute(:max_price, offers.max(:price))
  end

  def manufacturer_title
    manufacturer.title if manufacturer?
  end

  def as_json_for_catalog
    options = {
      except: [:_id, :_keywords, :category_id, :cover_filename],
      include: {
        category: {
          methods: [:slug],
          only: [
            :slug,
            :title
          ],
          # Часть для кастомных полей
          # include: {
          #   product_attributes: {
          #     only: [:name, :title, :type, :unit]
          #   }
          # }
        },
        offers: {
          only: [
            :price
          ],
          include: {
            user: {
              only: [:store_profile],
              include: {
                store_profile: {
                  only: [
                    :slug,
                    :name
                  ]
                }
              }
            }
          }
        }
      }
    }

    return serializable_hash(options)
  end

  private
    # Часть для кастомных полей
    # def custom_field_to_datatype
    #   self.category.product_attributes.each do |pr_at|
    #     name = pr_at.name.to_sym
    #     if pr_at.type == 'boolean'
    #       self[name] = self[name].to_bool
    #     elsif pr_at.type == 'integer'
    #       self[name] = self[name].to_i
    #     end
    #   end
    # end

    # def custom_fields_validator
    #   max_length = 30
    #   max_integer = 9223372036854775807
    #   min_integer = -9223372036854775807

    #   self.category.product_attributes.each do |pr_at|
    #     name = pr_at.name.to_sym

    #     case pr_at.type
    #     when 'string'
    #       errors.add(name, "Длина строки должна быть не больше #{max_length} символов") if self[name].length > max_length
    #     # when 'boolean'
    #     #   # do nothing
    #     when 'integer'
    #       if self[name] > max_integer
    #         errors.add(name, "Значение должно быть не больше #{max_integer}")
    #       elsif self[name] < min_integer
    #         errors.add(name, "Значение должно быть не меньше #{min_integer}")
    #       end
    #     end
    #   end
    # end

    # def clear_old_custom_fields
    #   current = category.product_attributes.map(&:name)
    #   old = []
    #   dynamic_attributes.each do |dyn_at|
    #     old << dyn_at unless current.include?(dyn_at)
    #   end
    #   unset(old)
    # end

    # def dynamic_attributes
    #   attributes.keys - fields.keys
    # end
end
