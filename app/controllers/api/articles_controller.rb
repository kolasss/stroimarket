class Api::ArticlesController < ApplicationController
  respond_to :json

  def index
    respond_with Article.json_tree(Article.roots)
  end

  def show
    post = Article.find(params[:id])
    respond_with post,
      except: [:_slugs, :cover_filename],
      include: {
        children:{
          methods: [:slug],
          only: [:title]
        },
        documents: {
          methods: [:common_type]
        }
      }

  end
end
