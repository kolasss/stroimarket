class ProductAttribute
  include Mongoid::Document

  embedded_in :category

  TYPES = %w(
    boolean
    integer
    list
  )

  field :name, type: String
  field :title, type: String
  field :type, type: String, default: TYPES[0]
  field :unit, type: String

  validates :title, :presence => true
  validates :name, :presence => true
  validates_inclusion_of :type, in: TYPES
  # validates :unit, :length => { :is => 0, message: 'Должно быть пустым, если тип данных двоичный' }, if: :boolean?

  before_validation :add_attribute_name
  before_validation :capitalize_title
  # before_validation :unit_to_array, if: :list?

  # def boolean?
  #   type == "boolean"
  # end

  # def list?
  #   type == "list"
  # end

  def unit_list=(unit_string)
    if type == "list"
      self.unit = unit_string.split(',').map(&:strip)
    elsif type == "boolean"
      self.unit = ""
    else
      self.unit = unit_string
    end
  end

  def unit_list
    if type == "list"
      JSON.parse(self.unit).join(', ')
    else
      self.unit
    end
  end

  private
    def add_attribute_name
      self.name = self.title.gsub(/['`]/, "").parameterize(sep = '_')
    end

    def capitalize_title
      self.title[0] = self.title[0].mb_chars.capitalize.to_s
    end

    # def unit_to_array
    #   self.unit = "" unless self.unit.respond_to?(:split)

    #   self.unit = self.unit.split(',').collect(&:strip)
    # end

end
