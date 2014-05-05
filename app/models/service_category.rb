class ServiceCategory
  include CommonCategory

  has_many :services, dependent: :destroy

  def self.json_tree(nodes)
    nodes.map do |node|
      {
        :label => node.title,
        :id => node.id.to_s,
        :slug => node.slug,
        :children => json_tree(node.children).compact
      }
    end
  end
end
