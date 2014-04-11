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

  def self.json_tree(nodes)
    nodes.map do |node|
      {
        :label => node.title,
        :id => node.id.to_s,
        :slug => node.slug,
        :custom_attributes => node.product_attributes.as_json,
        :children => json_tree(node.children).compact
      }
    end
  end

  def self_and_children_ids
    descendants.pluck(:id) << id
  end
end
