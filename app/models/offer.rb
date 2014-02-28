class Offer
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :product
  belongs_to :user

  field :price, type: Integer

  validates :price, :presence => true, numericality: true
  validates :user_id, :presence => true, :uniqueness => {:scope => :product_id}
  validates :product_id, :presence => true
end
