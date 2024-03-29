ActiveAdmin.register About, as: 'About' do
  actions :all, except: [:destroy, :new, :create]

  permit_params :description

  remove_filter :image_attachment, :image_blob

  controller do
    def scoped_collection
      end_of_association_chain.limit(1)
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
