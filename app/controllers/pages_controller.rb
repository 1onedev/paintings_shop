class PagesController < BaseController
  def about_us
    set_seo(load_page_aboutus_seo)
  end

  def contact_us
    set_seo(load_page_contact_seo)
  end

  def payments_success
    check_uid
    @order = Order.find_by(uid: params[:uid])

    set_seo(load_page_payments_success_seo)
  end

  def faqs
    @faqs = Answer.order(created_at: :desc).all

    set_seo(load_page_faqs_seo)
  end

  def help
    set_seo(load_page_help_seo)
  end

  private

  def check_uid
    return if params[:uid] == cookies[:order]
    raise ActionController::RoutingError.new('Not Found')
  end  

  def load_page_aboutus_seo
    OpenStruct.new(seo_title: "#{t 'abouts_page'}", seo_description: settings.about_market, image: '/favicon/ou.jpg')
  end

  def load_page_contact_seo
    OpenStruct.new(seo_title: "#{t 'contacts'}", seo_description: settings.about_market, image: '/favicon/ou.jpg')
  end

  def load_page_payments_success_seo
    OpenStruct.new(seo_title: "#{t 'successful_payment'}", seo_description: settings.about_market, image: '/favicon/ou.jpg')
  end

  def load_page_faqs_seo
    OpenStruct.new(seo_title: "FAQ`s", seo_description: settings.about_market, image: '/favicon/ou.jpg')
  end

  def load_page_help_seo
    OpenStruct.new(seo_title: "#{t 'help'}", seo_description: settings.about_market, image: '/favicon/ou.jpg')
  end
end
