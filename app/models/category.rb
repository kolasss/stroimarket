class Category
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Tree::Ordering
  include Mongoid::Slug

  embeds_many :product_attributes
  has_many :products, dependent: :destroy

  field :title, type: String

  validates :title, :presence => true

  slug :title, history: true

  before_destroy :destroy_children

  accepts_nested_attributes_for :product_attributes, :allow_destroy => true, :reject_if => :all_blank
end
