class Category
  include Mongoid::Document
  include Mongoid::Tree
  # include Mongoid::Tree::Ordering
  include Ordering_fixed

  embeds_many :product_attributes
  has_many :products

  field :title, type: String

  validates :title, :presence => true
  # validate :attribute_list_is_valid

  before_destroy :destroy_children
  # before_save :add_attribute_name

  accepts_nested_attributes_for :product_attributes, :allow_destroy => true, :reject_if => :all_blank


  # private
  #   def add_attribute_name
  #     if self.attr_list
  #       self.attr_list.each do |key, value|
  #         self.attr_list[key][:name] = value[:title].gsub(/['`]/, "").parameterize(sep = '_') if value[:title]
  #       end
  #     end
  #   end

  #   def attribute_list_is_valid
  #     if self.attr_list.is_a?(Hash)
  #       self.attr_list.each do |key, value|
  #         if self.attr_list[key][:title].blank?
  #           self.errors.add(:attr_list_title, :title => "Title is blank")
  #         end
  #         if self.attr_list[key][:type] != :integer && !self.attr_list[key][:unit].blank?
  #           self.errors.add(:attr_list_unit, :unit => "Unit is not blank")
  #         end
  #       end
  #     end
  #   end
end
