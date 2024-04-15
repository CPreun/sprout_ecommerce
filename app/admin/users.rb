ActiveAdmin.register User do
  permit_params :email, :name, :first_name, :last_name, :phone, :street, :city, :postal_code, :province_id

  filter :name
  filter :first_name
  filter :last_name
  filter :email
  filter :phone
  filter :city
  filter :province_id, as: :select, collection: Province.all.map { |province| [province.province, province.id] }
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column :name
    column :first_name
    column :last_name
    column :email
    column :phone
    column :street
    column :city
    column :postal_code
    column "Province" do |user|
      user.province.present? ? user.province.province : ""
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :provider
      row :first_name
      row :last_name
      row :email
      row :phone
      row :street
      row :city
      row :postal_code
      row "Province" do |user|
        user.province.present? ? user.province.province : ""
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone
      f.input :street
      f.input :city
      f.input :postal_code
      f.input :province_id, as: :select, collection: Province.all.map { |province| [province.province, province.id] }
    end
    f.actions
  end
  
end
