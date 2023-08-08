class Ajax::CartsController < ::Ajax::BaseController
  def create
    cookies_items = cookies[:items].split(',')
    cookies_items << params['item']
    cookies[:items] = cookies_items.uniq.compact.join(',')
  end

  def destroy
    cookies_items = cookies[:items].split(',')
    cookies_items -= [params['item']]
    cookies[:items] = cookies_items.uniq.compact.join(',')

    @from_cart = params[:from_cart]

    puts @from_cart
  end
end
