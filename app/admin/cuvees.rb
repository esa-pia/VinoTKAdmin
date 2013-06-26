ActiveAdmin.register Cuvee do
  menu :parent => I18n.t('menu.bouteilles_info')

  xlsx(:i18n_scope => [:active_admin, :axlsx, :cuvees],
       :header_style => {:bg_color => 'FF0000', :fg_color => 'FF' }) do

    # deleting columns from the report
    delete_columns :id, :created_at, :updated_at

    # adding a column to the report
    #column(:libelle)
  end

  index do
    selectable_column
    column :libelle
    default_actions
  end
  
  controller do
    def per_page 
   		return max_csv_records if request.format == 'text/csv' ||  request.format == 'application/json'  ||  request.format == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
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
