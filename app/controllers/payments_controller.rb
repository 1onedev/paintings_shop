class PaymentsController < BaseController
  skip_before_action :initialize_cookies_items, only: :create, raise: false
  skip_before_action :initialize_cookies_favorites, only: :create, raise: false
  skip_before_action :verify_authenticity_token, only: :create, raise: false

  def show
    check_uid
    @order = Order.find_by(uid: params[:uid])

    set_seo(load_page_seo)

    require 'liqpay'
    liqpay = Liqpay.new

    @liqpay_form = liqpay.cnb_form({
      action:       "pay",
      amount:       "#{@order.total_price}",
      currency:     "USD",
      description:  "Paintings shop | #{@order.number_with_sign}",
      order_id:     "#{@order.uid}",
      version:      "3",
      language:     "#{params[:locale]}",
      result_url:   "#{payment_path(uid: @order.uid)}",
      server_url:   "#{payments_path}"
    })
  end

  def create
    data      = request.parameters['data']
    signature = request.parameters['signature']

    require 'liqpay'
    liqpay = Liqpay.new

    if liqpay.match?(data, signature)
      responce_hash = liqpay.decode_data(data)

      ::Transactions::Create.call(params: responce_hash)
    else
    # Wrong signature!
    end

    head :ok
  end

  private

  def check_uid
    return if params[:uid] == cookies[:order]
    raise ActionController::RoutingError.new('Not Found')
  end  

  def load_page_seo
    OpenStruct.new(seo_title: "#{t 'pay'}", seo_description: settings.about_market, image: '/favicon/ou.jpg')
  end
end