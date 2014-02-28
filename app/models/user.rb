class User
  include Mongoid::Document
  include Mongoid::Timestamps

  ROLES = %w(
    admin
    seller
    user
  )

  embeds_one :store_profile
  has_many :offers, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  field :role,    :type => String, :default => "user"
  field :name,    :type => String

  validates_presence_of :name
  validates_inclusion_of :role, in: ROLES

  # default_scope ->{ order_by(:created_at => :desc) }

  scope :sellers, ->{ where(role: "seller") }

  def user?
    role == "user"
  end

  def seller?
    role == "seller"
  end

  def admin?
    role == "admin"
  end

  def company_name
    self.store_profile? ? self.store_profile.name : name
  end
end
