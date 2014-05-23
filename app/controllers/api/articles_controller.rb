class Api::ArticlesController < ApplicationController
  respond_to :json

  def index
    # posts = Article.all
    # respond_with posts,
    #   methods: [:slug],
    #   except: [:_id, :body, :_slugs, :cover_filename]
    respond_with Article.json_tree(Article.roots)
  end

  def show
    post = Article.find(params[:id])
    respond_with post,
      except: [:_id, :_slugs, :cover_filename],
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
