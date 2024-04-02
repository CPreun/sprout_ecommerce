ActiveAdmin.register About, as: 'About Us' do
  menu parent: 'Site Info'

  actions :all, except: [:destroy, :new, :create]
  permit_params :description, :image
  config.filters = false

  controller do
    def scoped_collection
      end_of_association_chain.limit(1)
    end

    def index
      redirect_to admin_about_u_path(About.first.id)
    end
  end

  show do
    attributes_table do
      row :description
      row :image do |about|
        about.image.present? ? image_tag(about.image, size: '100x100') : content_tag(:span, "No Image")
      end
      row :updated_at
      row :created_at
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :description
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image, size: '100x100') : content_tag(:span, "Upload image")
    end
    f.actions
  end
end
