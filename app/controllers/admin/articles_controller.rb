class Admin::ArticlesController < AdminController
  load_and_authorize_resource
  skip_load_resource :only => [ :create ]
  # before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    # @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    # @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to admin_article_path(@article), notice: 'Article was successfully created.' }
        format.json { render action: 'show', status: :created, location: @article }
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to admin_article_path(@article), notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to admin_articles_url }
      format.json { head :no_content }
    end
  end

  def update_position
    if params[:prev_id]
      @article.move_below(Article.find(params[:prev_id]))
    else
      if params[:parent_id]
        @article.parent = Article.find(params[:parent_id])
      else
        @article.parent = nil
      end

      if @article.save
        @article.move_to_top
      else
        render json: @article.errors, status: :unprocessable_entity
        return
      end
    end
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_article
    #   @article = Article.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
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
