class Admin::PostsController < Admin::BaseController
  def index 
    @post_all = Post.order(created_at: :desc).all

    @posts = Post.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @post = load_post
  end

  def new
    @post = Post.new
  end

  def edit
    @post = load_post
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to admin_post_path(@post), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@post.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @post = load_post

    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@post.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @post = load_post

    @post.destroy

    redirect_to admin_posts_path, notice: 'Дані видалено'
  end

  private

  def load_post
    Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
      :name,
      :name_en,
      :text,
      :text_en,
      :published,
      :image
    )
  end
end