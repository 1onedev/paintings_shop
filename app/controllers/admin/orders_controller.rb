class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @order = load_order

    @order_items = OrderItem.where(order: @order).order(created_at: :desc).all
  end

  def destroy
    @order = load_order

    @order.destroy

    redirect_to admin_orders_path, notice: 'Дані видалено'
  end

  private

  def load_order
    Order.find(params[:id])
  end
end