class Service
  include Mongoid::Document

  belongs_to :service_category
  belongs_to :user

  field :title, type: String
  field :body, type: String

  validates :service_category_id, :presence => true
  validates :user_id, :presence => true

  def as_json_for_catalog
    options = {
      except: [:_id, :_keywords, :service_category_id, :user_id],
      include: {
        service_category: {
          methods: [:slug],
          only: [
            :slug,
            :title
          ]
        },
        user: {
          only: [:store_profile],
          include: {
            store_profile: {
              only: [
                :slug,
                :name
              ]
            }
          }
        }
      }
    }

    return serializable_hash(options)
  end
end
