class Manufacturer
  include Mongoid::Document
  include Mongoid::Search

  field :title, type: String

  search_in :title

  has_many :products, dependent: :nullify
  has_and_belongs_to_many :categories
end
