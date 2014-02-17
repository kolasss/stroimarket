class ProductAttribute
  include Mongoid::Document

  embedded_in :category

  TYPES = %w(
    string
    integer
    boolean
  )

  field :name, type: String
  field :title, type: String
  field :type, type: String, default: TYPES[0]
  field :unit, type: String

  validates :title, :presence => true
  validates :name, :presence => true
  validates_inclusion_of :type, in: TYPES
  validates :unit, :length => { :is => 0, message: 'Должно быть пустым, если тип данных не цифровой' }, if: :not_integer?

  before_validation :add_attribute_name
  before_validation :capitalize_title

  def not_integer?
    type != "integer"
  end

  private
    def add_attribute_name
      self.name = self.title.gsub(/['`]/, "").parameterize(sep = '_')
    end

    def capitalize_title
      self.title[0] = self.title[0].mb_chars.capitalize.to_s
    end
end
