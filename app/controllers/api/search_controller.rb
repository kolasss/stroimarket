class Api::SearchController < ApplicationController
  respond_to :json

  def show
    result = {}

    result[:products] = Product.full_text_search(params[:id]).as_json(
      except: [:body, :_keywords, :cover_filename, :category_id, :manufacturer_id],
      methods: [:manufacturer_title]
    )

    result[:manufacturers] = Manufacturer.full_text_search(params[:id]).as_json(
      only: [:title]
    )

    result[:services] = Service.full_text_search(params[:id]).as_json(
      except: [:body, :service_category_id, :_keywords]
    )

    respond_with result
  end
end
