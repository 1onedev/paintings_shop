class PostsController < BaseController
  def index
    @posts = Post.published.order(created_at: :desc).page(params[:page]).per(6)

    @recent_posts = Post.published.order(created_at: :desc).limit(4)

    @item_categories = ItemCategory.order(name: :desc).all

    set_seo(load_page_seo)
  end

  def show
    @post = load_post

    @posts = Post.published.order(created_at: :desc).page(params[:page]).last(4)

    @item_categories = ItemCategory.order(name: :desc).all

    set_seo(@post)
  end

  def load_post
    Post.find(params[:id])
  end

  def load_page_seo
    OpenStruct.new(seo_title: "#{t 'news_page'}", seo_description: settings.about_market, image: '/favicon/ou.jpg')
  end
end
