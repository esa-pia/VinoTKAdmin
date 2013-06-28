ActiveAdmin.register Type do
  menu :parent => I18n.t('menu.bouteilles_info')

  filter :libelle, :label => I18n.t('types.libelle')

  index do
    selectable_column
    column I18n.t('types.libelle'),:libelle
    default_actions
  end

  show do |type|
    panel I18n.t('types.section_title') do
      attributes_table_for type do
        row (I18n.t('types.id')) {type.id}
        row (I18n.t('types.libelle')) {type.libelle}
      end
    end
    active_admin_comments
  end

  form do |f|                         
    f.inputs I18n.t('types.section_title') do       
      f.input :libelle , :label => I18n.t('types.libelle')
    end                               
    f.actions                         
  end
  # -----------------------------------------------------------------------------------
  # XLS
  xlsx(:i18n_scope => [:active_admin, :axlsx, :types],
       :header_style => {:bg_color => 'FF0000', :fg_color => 'FF' }) do

    # deleting columns from the report
    delete_columns :id, :created_at, :updated_at

    # adding a column to the report
    #column(:libelle)
  end
  # -----------------------------------------------------------------------------------
  # CONTROLLER
  controller do
    def per_page 
   		return max_csv_records if request.format == 'text/csv' ||  request.format == 'application/json'   ||  request.format == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
   		return max_per_page if active_admin_config.paginate == false 
   		@per_page || active_admin_config.per_page 
 	  end
    def index
      if(!params[:order])
        params[:order] = "libelle_asc"
      end
      super
    end
  end
end
