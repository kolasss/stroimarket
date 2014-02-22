class ArticlesController < ApplicationController
  def show
    @article = Article.find_by(path: params[:path])

    # render @article
  end
end
