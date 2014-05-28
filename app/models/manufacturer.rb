class Manufacturer
  include Mongoid::Document
  include Mongoid::Search

  field :title, type: String
  field :slug, type: String

  search_in :title

  has_many :products, dependent: :nullify
  has_and_belongs_to_many :categories

  validates :title, presence: true
  validates :slug, presence: true

  before_validation :add_slug, if: :title_changed?

  private
    def add_slug
      self.slug = self.title.gsub(/['`]/, "").parameterize(sep = '_')
    end
end
