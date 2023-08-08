class CartsController < BaseController
  def show
    set_seo(load_page_seo)
  end

  def create
    result = Orders::Create.call(
      params: order_params
    )
    
    if result.success?
      cookies[:order] = result.order.uid
      cookies[:items] = ''

      redirect_to payment_path(uid: result.order.uid)
    else
      puts "............ order_error #{result.error } ............"
      render action: :show, flash: { error: 'Ошибка создания заказа.' }
    end  
  end

  def update
    @order = Order.find_by(uid: params[:uid])

    if @order.update(order_params)
      redirect_to payment_path(uid: result.order.uid), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@order.errors.full_messages.join(', ')}"

      render :edit
    end
  end
  
  private

  def order_params
    params.require(:order).permit(
      :name,
      :surname,
      :phone, 
      :email,
      :locality,
      :delivery_service,
      :delivery_type, 
      :delivery_comment, 
      order_items_attributes: [:id, :item_id, :price, :_destroy]
    ).merge(user: current_user)
  end

  def load_page_seo
    OpenStruct.new(seo_title: "#{t 'cart'}", seo_description: settings.about_market, image: '/favicon/ou.jpg')
  end
end
