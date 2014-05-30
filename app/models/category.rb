class Category
  include CommonCategory

  embeds_many :product_attributes
  has_many :products, dependent: :destroy
  has_and_belongs_to_many :manufacturers

  accepts_nested_attributes_for :product_attributes, :allow_destroy => true, :reject_if => :all_blank

  mount_uploader :background, CategoryImageUploader

  def self.json_tree(nodes)
    nodes.map do |node|
      {
        :title => node.title,
        :id => node.id.to_s,
        :slug => node.slug,
        :background => node.background.url,
        :parent_title => node.parent? ? node.parent.title : '',
        :product_attributes => node.product_attributes.as_json,
        :children => json_tree(node.children).compact
      }
    end
  end
end
