ActiveAdmin.register Province do
  menu parent: "Site Info"

  actions :all, except: [:destroy, :new, :create]  
  permit_params :province, :code, :pst, :gst, :hst
  config.filters = false

  index do
    column :province
    column :code
    column :pst
    column :gst
    column :hst
    column :updated_at
    actions
  end
end
