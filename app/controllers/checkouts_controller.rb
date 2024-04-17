class CheckoutsController < ApplicationController
  before_action :set_user

  def set_user
    @user = user_signed_in? ? current_user : User.new
  end

  def shipping
    @user
  end

  # def create
  #   user = User.find_or_create_by(email: params[:user][:email])
  #   user.update(params.require(:user).permit(:first_name, :last_name, :phone, :street, :city, :postal_code, :province_id))
  #   redirect_to "/checkout/summary"
  # end

  # def update
  #   current_user.update(params.require(:user).permit(:first_name, :last_name, :phone, :street, :city, :postal_code, :province_id))
  #   redirect_to "/checkout/summary"
  # end

  def summary
    @order = Order.includes(:order_items, :user).find(session[:order])
    @order_items = OrderItem.includes(:plant).where(order_id: @order)
    puts @order_items.inspect
    @subtotal = @order_items.sum { |item| item.unit_price.to_d * item.quantity.to_i }
    puts "Subtotal: #{@subtotal}"
    @total = @subtotal + (@order.gst.present? ? @order.gst : 0 * @subtotal) + (@order.pst.present? ? @order.pst : 0 * @subtotal) + (@order.hst.present? ? @order.hst : 0 * @subtotal)
  end
end
