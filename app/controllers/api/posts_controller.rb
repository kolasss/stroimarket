class Api::PostsController < ApplicationController
  respond_to :json

  def index
    posts = Post.all
    respond_with posts,
      methods: [:slug],
      except: [:_id, :body, :_slugs, :cover_filename]
  end

  def show
    post = Post.find(params[:id])
    respond_with post,
      except: [:_id, :_slugs, :cover_filename]
  end
end
