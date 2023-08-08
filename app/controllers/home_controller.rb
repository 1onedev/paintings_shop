class HomeController < BaseController
  def index
    @items = Item.published.order(created_at: :desc).page(params[:page]).per(8)

    @item_categories = ItemCategory.order(name: :desc).limit(5)

    @posts = Post.published.order(created_at: :desc).limit(3)

    @sliders = Slider.order(created_at: :desc).all

    @partners = Partner.order(created_at: :desc).all

    set_seo(load_page_seo)
  end

  def load_page_seo
    OpenStruct.new(seo_title: "#{t 'home_page'}", seo_description: settings.about_market, image: '/favicon/ou.jpg')
  end
end
