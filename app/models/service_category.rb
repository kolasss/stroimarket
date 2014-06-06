class ServiceCategory
  include CommonCategory

  has_many :services, dependent: :destroy

end
