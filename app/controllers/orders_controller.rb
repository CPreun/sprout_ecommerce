class OrdersController < ApplicationController
  # def index
  #   @orders = Order.where(user_id: current_user.id)
  #   puts @orders
  # end

  # def show
  #   @order = Order.find(params[:id])
  #   puts @order
  # end

  def create
    user = user_signed_in? ? current_user : User.find_or_create_by(email: params[:user][:email])
    puts "USER: #{user.inspect}"
    puts user.errors.full_messages
    user.update(params.require(:user).permit(:first_name, :last_name, :email, :phone, :street, :city, :postal_code, :province_id))
    create_order(user)
  end

  # def update
  #   puts params
  # end

  def create_order(user)
    order = Order.new(user_id: user.id)
    if user.province.gst.present? and user.province.gst > 0 then order.gst = user.province.gst end
    if user.province.pst.present? and user.province.pst > 0 then order.pst = user.province.pst end
    if user.province.hst.present? and user.province.hst > 0 then order.hst = user.province.hst end
    order.save
    puts order.inspect
    # {"plant_id"=>"405", "amounts"=>[{"quantity"=>"3", "price_id"=>"2576"}]}
    # {"plant_id"=>"307", "amounts"=>[{"quantity"=>1, "price_id"=>"1972"}, {"quantity"=>2, "price_id"=>"1973"}]}

    session[:cart].each do |item|
      item['amounts'].each do |amount|
        price_weight = Price.where(id: amount['price_id'].to_i).pluck(:price, :weight)
        puts "Unit Price: #{price_weight[0][0]}, Weight: #{price_weight[0][1]}"
        order_item = OrderItem.new(plant_id: item['plant_id'], quantity: amount['quantity'], unit_price: price_weight[0][0], weight: price_weight[0][1], order_id: order.id)
        puts order_item.inspect
        order_item.save
      end
    end

    #<ActiveRecord::Relation [#<OrderItem id: 1, plant_id: 405, quantity: 3, weight: nil, unit_price: 0.0, gst_rate: nil, pst_rate: nil, hst_rate: nil, order_id: 1, created_at: "2024-04-17 14:20:16.236272000 +0000", updated_at: "2024-04-17 14:20:16.236272000 +0000">, 
    #<OrderItem id: 2, plant_id: 307, quantity: 1, weight: nil, unit_price: 0.0, gst_rate: nil, pst_rate: nil, hst_rate: nil, order_id: 1, created_at: "2024-04-17 14:20:16.260596000 +0000", updated_at: "2024-04-17 14:20:16.260596000 +0000">, 
    #<OrderItem id: 3, plant_id: 307, quantity: 2, weight: nil, unit_price: 0.0, gst_rate: nil, pst_rate: nil, hst_rate: nil, order_id: 1, created_at: "2024-04-17 14:20:16.288848000 +0000", updated_at: "2024-04-17 14:20:16.288848000 +0000">]>

    puts order.inspect
    # puts order.order_items
    # puts order.order_items.inspect

    session[:cart] = []
    session[:order] = order.id

    redirect_to "/checkout/summary"    
  end
end
