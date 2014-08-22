class StoreProfile
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user

  field :name, type: String
  field :contacts, type: String
  field :requisites, type: String
  field :phone, type: String
  field :site, type: String
  field :email, type: String
  field :info, type: String
  field :slug, type: String
  field :about, type: String
  field :pavilion, type: String

  mount_uploader :logo, LogoUploader
  mount_uploader :header, HeaderUploader

  validates :name, presence: true

  before_validation :add_slug, if: :name_changed?

  def user_id
    user.id.to_s
  end

  private
    def add_slug
      self.slug = self.name.gsub(/['`]/, "").parameterize(sep = '_')
    end
end
