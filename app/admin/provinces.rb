ActiveAdmin.register Province do
  actions :all, except: [:destroy, :new, :create]
  
  permit_params :province, :code, :pst, :gst, :hst

  filter :province
  filter :code  
end
