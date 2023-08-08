class User::OrdersController < ::User::BaseController
  def index
    @orders = Order.where(user: current_user).order(created_at: :desc).page(params[:page]).per(5)

    set_seo(load_page_seo)
  end

  def show
    @order = load_order

    set_seo(load_page_seo)
  end

  private

  def load_order
    Order.find(params[:id])
  end

  def load_page_seo
    OpenStruct.new(seo_title: "Мої замовлення", seo_description: settings.about_market, image: '/favicon/ou.jpg')
  end
end