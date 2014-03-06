class Admin::ArticlesController < AdminController
  include AdminPositionable

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
    authorize AdminController
  end

  def show
  end

  def new
    @article = Article.new
    authorize AdminController
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    authorize AdminController

    if @article.save
      redirect_to admin_article_path(@article), notice: t(:created)
    else
      render action: 'new'
    end
  end

  def update
    if @article.update(article_params)
      redirect_to admin_article_path(@article), notice: t(:updated)
    else
      render action: 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to admin_articles_url
  end

  private
    def set_article
      @article = Article.find(params[:id])
      authorize AdminController
    end

    def article_params
      safe_attributes = [
        :title,
        :intro,
        :body,
        :cover,
        :remove_cover,
        :menu_title,
        documents_attributes: [
          :id,
          :title,
          :file,
          :_destroy
        ],
        images_attributes: [
          :id,
          :title,
          :file,
          :_destroy
        ]
      ]
      params.require(:article).permit(*safe_attributes)
    end
end
