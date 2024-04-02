ActiveAdmin.register Contact, as: "Contact Us"  do
  menu parent: "Site Info"

  actions :all, except: [:destroy, :new, :create]
  permit_params :email, :phone, :street, :city, :postal_code, :province_id, :created_at, :updated_at
  config.filters = false

  controller do
    def scoped_collection
      end_of_association_chain.limit(1)
    end

    def index
      redirect_to admin_contact_u_path(Contact.first.id)
    end
  end

  show do
    attributes_table do
      row :email
      row :phone
      row :street
      row :city
      row "Province" do |contact|
        contact.province.province
      end
      row :postal_code
      row :updated_at
      row :created_at
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :phone
      f.input :email
      f.input :street
      f.input :city
      f.input :province_id, as: :select, collection: Province.all.map { |province| [province.province, province.id] }
      f.input :postal_code
    end
    f.actions
  end
  
end
