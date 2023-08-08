class WishlistsController < BaseController
  def show
    @items = Item.where(id: cookies[:favorites].split(',').uniq).order(created_at: :desc).page(params[:page]).per(5)

    set_seo(load_page_seo)
  end

  def load_page_seo
    OpenStruct.new(seo_title: "#{t 'wishlist_page'}", seo_description: settings.about_market, image: '/favicon/ou.jpg')
  end
end
