class OrdersController < ApplicationController
  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    order = Order.new(user_id: current_user.id, status_id: Status.find_by(status: 'Pending').id, paid: false, shipping_id: nil)
    order.save

    session[:cart].each do |item|
      order_item = OrderItem.new(plant_id: item['plant_id'], quantity: item['quantity'], order_id: order.id)
      order_item.save
    end

    session[:cart] = []
    redirect_to checkout_path
  end
end
