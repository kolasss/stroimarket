class Manufacturer
  include Mongoid::Document

  field :title, type: String

  has_many :products, dependent: :nullify
  has_and_belongs_to_many :categories
end
