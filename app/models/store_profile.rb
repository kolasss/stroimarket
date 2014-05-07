class StoreProfile
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user

  field :name, type: String
  field :title, type: String
  field :ogrn, type: String
  field :address, type: String
  field :phone, type: String
  field :slug, type: String

  validates :name, presence: true
  validates :title, presence: true

  before_validation :add_slug

  def user_id
    user.id.to_s
  end

  private
    def add_slug
      self.slug = self.name.gsub(/['`]/, "").parameterize(sep = '_')
    end
end
