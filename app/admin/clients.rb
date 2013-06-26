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

  xlsx(:i18n_scope => [:active_admin, :axlsx, :clients],
       :header_style => {:bg_color => 'FF0000', :fg_color => 'FF' }) do

    # deleting columns from the report
    delete_columns :id, :created_at, :updated_at , :nom, :prenom, :email

    column (:nom)   { |client| "#{client.nom} #{client.prenom}" }
    column (:email) { |client| client.email    }

  end



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
