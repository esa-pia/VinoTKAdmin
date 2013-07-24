ActiveAdmin.register Client do


  filter :nom, :label => I18n.t('clients.nom')
  filter :prenom, :label => I18n.t('clients.prenom')
  filter :email, :label => I18n.t('clients.email')
  filter :inactif, :label => I18n.t('clients.inactif')

  index do
    selectable_column
    column I18n.t('clients.nom'), :nom
    column I18n.t('clients.prenom'), :prenom
    column I18n.t('clients.email'), :email
    column I18n.t('clients.inactif'), :inactif
    default_actions
  end

  show do |client|
    panel I18n.t('clients.section_title') do
      attributes_table_for client do
        row (I18n.t('clients.id')) {client.id}
        row (I18n.t('clients.nom')) {client.nom}
        row (I18n.t('clients.prenom')) {client.prenom}
        row (I18n.t('clients.email')) {client.email}
        row (I18n.t('clients.inactif')) {client.inactif}
      end
    end
    active_admin_comments
  end

  form do |f|                         
    f.inputs I18n.t('clients.section_title') do       
      f.input :nom , :label => I18n.t('clients.nom')                 
      f.input :prenom , :label => I18n.t('clients.prenom')               
      f.input :email, :label => I18n.t('clients.email')   
      f.input :inactif, :label => I18n.t('clients.inactif')  
    end                               
    f.actions                         
  end
  
  action_item :only => [:show] do
    link_to(I18n.t('active_admin.new_model', :model => active_admin_config.resource_label), new_resource_path)
  end
  
  # -----------------------------------------------------------------------------------
  # XLS
  xlsx(:i18n_scope => [:active_admin, :axlsx, :clients],
       :header_style => {:bg_color => 'FF0000', :fg_color => 'FF' }) do

    # deleting columns from the report
    delete_columns :id, :created_at, :updated_at , :nom, :prenom, :email

    column (:nom ) { |client| "#{client.nom} #{client.prenom}" }
    column (:email)
    column (:inactif)
  end

  # -----------------------------------------------------------------------------------
  # CONTROLLER
  controller do
    def per_page
      return max_csv_records if request.format == 'text/csv' ||  request.format == 'application/json'  ||  request.format == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      return max_per_page if active_admin_config.paginate == false
      @per_page || active_admin_config.per_page
    end
    def index
      if(!params[:order])
        params[:order] = "nom_asc"
      end
      super
    end
  end
end
