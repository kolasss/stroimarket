class Admin::PostsController < AdminController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # after_action :verify_authorized, :except => [:index, :show]

  def index
    @posts = Post.all
    authorize AdminController
  end

  def show
  end

  def new
    @post = Post.new
    authorize AdminController
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    authorize AdminController

    if @post.save
      redirect_to admin_post_path(@post), notice: 'Post was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: 'Post was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path
  end

  private
    def set_post
      @post = Post.find(params[:id])
      authorize AdminController
    end

    def post_params
      params.require(:post).permit(
        :title,
        :intro,
        :body,
        :cover,
        :remove_cover
      )
    end
end
