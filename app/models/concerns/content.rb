module Content
  extend ActiveSupport::Concern

  included do
    field :title, type: String
    field :intro, type: String
    field :body, type: String


    validates :title, :presence => true
    validates :body, :presence => true
  end

  # module ClassMethods

  # end
end
