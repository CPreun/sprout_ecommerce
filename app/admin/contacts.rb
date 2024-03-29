ActiveAdmin.register Contact do
  actions :all, except: [:destroy, :new, :create]

  permit_params :email, :phone, :street, :city, :postal_code, :province_id, :created_at, :updated_at

  filter :updated_at

  controller do
    def scoped_collection
      end_of_association_chain.limit(1)
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
