class Service
  include Mongoid::Document

  belongs_to :service_category

  field :title, type: String
  field :body, type: String

  validates :service_category_id, :presence => true
end
