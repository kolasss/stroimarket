# - require Ordering2
class Category
  include Mongoid::Document
  include Mongoid::Tree
  # include Mongoid::Tree::Ordering
  include Ordering_fixed

  ATTR_TYPES = [
    :string,
    :integer,
    :boolean
  ]

  field :title, type: String
  field :attr_list, type: Hash
  # field :position, type: Integer, default: 0

  validates :title, :presence => true

  scope :inactive, ->{ where(active: false) }
  default_scope -> {asc(:position)}
end
