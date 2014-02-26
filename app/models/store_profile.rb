class StoreProfile
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user

  field :name, type: String
  field :title, type: String
  field :ogrn, type: String
  field :address, type: String
  field :phone, type: String

  validates :name, :presence => true
  validates :title, :presence => true
end
