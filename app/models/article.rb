class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::Tree
  include Mongoid::Tree::Ordering
  include Content

  slug :title, history: true

  field :menu_title, type: String
  field :path, type: String

  before_destroy :move_children_to_parent
  before_validation :set_defaults
  before_save :populate_path
  before_save :rebuild_children_pathes, if: :path_changed?

  protected
    def set_defaults
      self.menu_title = title if menu_title.blank?
    end

    def populate_path
      self.path = parent_id.present? ? "#{parent.path}/#{slug}" : slug
    end

    def rebuild_children_pathes
      children.each do |c|
        c.populate_path
        c.save!
      end
    end
end
