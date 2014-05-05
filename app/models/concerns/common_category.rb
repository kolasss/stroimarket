module CommonCategory
  extend ActiveSupport::Concern

  included do
    include Mongoid::Document
    include Mongoid::Tree
    include Mongoid::Tree::Ordering
    include Mongoid::Slug

    field :title, type: String

    validates :title, :presence => true

    slug :title

    before_destroy :destroy_children
  end

  def self_and_children_ids
    descendants.pluck(:id) << id
  end

end
