module ArticlesHelper
  def article_path article
    article_page_path(path: article.path)
  end
end
