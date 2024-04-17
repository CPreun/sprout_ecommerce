ActiveAdmin.register Order do
  permit_params :status_id, :paid, :shipping_id, :user_id, :gst, :pst, :hst, 
                :order_items_attributes => [:id, :plant_id, :quantity, :unit_price, :weight, :_destroy]

  filter :user_id
  filter :paid
  filter :shipping_id
  filter :status_id, as: :select, collection: Status.all.map { |status| [status.status, status.id] }
  filter :created_at
  filter :updated_at

  controller do
    def scoped_collection
      Order.includes(:status, :user, :order_items)
    end
  end
  
  index do
    selectable_column
    column :id
    column :status do |order|
      order.status.status
    end
    column :paid
    column :shipping_id
    column :user
    column :gst
    column :pst
    column :hst
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row "Order ID" do |order|
        order.id
      end
      row :status do |order|
        order.status.status
      end
      row :paid
      row :shipping_id
      row :user
      row "Order Items" do |order|
        table_for order.order_items do
          column :plant
          column :quantity
          column :unit_price
          column :weight
        end
      end
      row :gst
      row :pst
      row :hst
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :id, label: "Order ID", input_html: { readonly: true, diabled: true }
      f.input :user, as: :string, label: "User", input_html: { readonly: true, disabled: true, value: f.object.user.email }
      f.input :status, as: :select, collection: Status.all.map { |status| [status.status, status.id] }
      f.input :paid
      f.input :shipping_id
      f.inputs "Order Items" do
        f.has_many :order_items, heading: false, allow_destroy: true do |oi|
          oi.input :plant
          oi.input :quantity
          oi.input :unit_price
          oi.input :weight
        end
      end
      f.input :gst
      f.input :pst
      f.input :hst
    end
    f.actions
  end
end
