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
    @order = Order.includes(:order_items, :user, :status, :plants).find(session[:order])
    @order_items = OrderItem.includes(:plant).where(order_id: @order)
    puts @order_items.inspect
    # @subtotal = @order_items.sum { |item| item.unit_price.to_d * item.quantity.to_i }
    @subtotal = @order.subtotal
    puts "Subtotal: #{@subtotal}"
    @total = @order.total
    # @total = @subtotal + (@order.gst.present? ? @order.gst : 0 * @subtotal) + (@order.pst.present? ? @order.pst : 0 * @subtotal) + (@order.hst.present? ? @order.hst : 0 * @subtotal)
  
  end

  def payment
    order = Order.includes(:order_items, :user, :status, :plants).find(1)
    subtotal = order.subtotal
    total = order.total

    @session = Stripe::Checkout::Session.create(
    #   {
    #   id: "checkout_#{Time.now.to_i}",
    #   currency: "cad",
    #   # customer: @user.id,
    #   customer_email: @user.email,
    #   amount_subtotal: (subtotal * 100).to_i,
    #   amount_tax: ((total - subtotal) * 100).to_i,
    #   amount_total: (total * 100).to_i,
    #   shipping_details: {
    #     address: {
    #       city: @user.city,
    #       country: "CA",
    #       line1: @user.street,
    #       postal_code: @user.postal_code,
    #       state: @user.province.code
    #     },
    #     name: @user.name,
    #   },
    #   mode: "payment",
    #   ui_mode: "embedded",
    #   return_url: CGI.unescape(checkout_url(session_id: '{CHECKOUT_SESSION_ID}')),
    # }
      line_items: [{
        price_data: {
          currency: "cad",
          product_data: {
            name: "Order No. #{order.id}",
          },
          unit_amount: (total * 100).to_i,
        },
        quantity: 1
      }],
      mode: "payment",
      ui_mode: "embedded",
      return_url: CGI.unescape(checkout_url(session_id: '{CHECKOUT_SESSION_ID}'))
    )

    order.update(stripe_id: @session.id)
  end

  def show
    @order = Order.find_by(stripe_id: params[:session_id])
    stripe_session = Stripe::Checkout::Session.retrieve(params[:session_id])

    # set alert and redirect to account page

    if stripe_session.status == "complete"
      @order.update(paid: true)
      session[:order] = nil
      flash[:success] = "Payment successful!"
      redirect_to "/account"
    else
      flash[:error] = "Payment failed. Please try again."
      redirect_to "/checkout/summary"
    end
  end
end
