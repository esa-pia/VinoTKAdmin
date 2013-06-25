ActiveAdmin.register Client do


  filter :nom
  filter :prenom
  filter :email

  index do
    selectable_column
    column :nom
    column :prenom
    column :email
    default_actions
  end

  controller do
    def per_page
      return max_csv_records if request.format == 'text/csv' ||  request.format == 'application/json'
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
