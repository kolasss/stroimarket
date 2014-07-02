class Service
  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Timestamps
  include Content
  include ProductFiles

  belongs_to :service_category
  belongs_to :user

  field :price, type: Integer
  field :views, type: Integer, default: 0

  search_in :title

  validates :service_category_id, :presence => true
  validates :user_id, :presence => true

  def store_title
    user.company_name if user?
  end

  def as_json_for_catalog
    options = {
      except: [:_id, :_keywords, :service_category_id, :product_images],
      include: {
        service_category: {
          methods: [:slug],
          only: [
            :_id,
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
                :name,
                :phone,
                :site,
                :email
              ]
            }
          }
        },
        images: {
          only: [
            :file,
            :title
          ]
        }
      }
    }

    return serializable_hash(options)
  end
end
