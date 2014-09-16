class Api::SearchController < ApplicationController
  respond_to :json

  def show
    result = {}

    result[:products] = Product.full_text_search(params[:id]).as_json(
      except: [:body, :_keywords, :cover_filename, :manufacturer_id],
      methods: [:offers_count]
    )

    result[:manufacturers] = Manufacturer.full_text_search(params[:id]).as_json(
      only: [:title, :slug]
    )

    result[:services] = Service.full_text_search(params[:id]).as_json(
      except: [:body, :_keywords, :cover_filename, :user_id],
      include: {
        user: {
          only: [:store_profile],
          include: {
            store_profile: {
              only: [
                :slug,
                :name,
              ]
            }
          }
        }
      }
    )

    respond_with result
  end
end
