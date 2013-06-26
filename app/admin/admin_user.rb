ActiveAdmin.register AdminUser, :as => I18n.t('menu.users') do
  menu  :label => proc{I18n.t('menu.users')}

  index do
    selectable_column
    column I18n.t('users.email'), :email
    column I18n.t('users.current_sign_in_at'), :current_sign_in_at
    column I18n.t('users.last_sign_in_at'), :last_sign_in_at
    column I18n.t('users.sign_in_count'), :sign_in_count
    default_actions                   
  end

  # -----------------------------------------------------------------------------------
  # XLS
  xlsx(:i18n_scope => [:active_admin, :axlsx, :users],
       :header_style => {:bg_color => 'FF0000', :fg_color => 'FF' }) do

    # deleting columns from the report
    delete_columns :id, :created_at, :updated_at , :encrypted_password , :reset_password_token , :reset_password_sent_at ,:remember_created_at, :current_sign_in_ip, :last_sign_in_ip

    column :sign_in_count
  end


  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions                         
  end

  controller do
    def per_page
      return max_csv_records if request.format == 'text/csv' ||  request.format == 'application/json' ||  request.format == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      return max_per_page if active_admin_config.paginate == false
      @per_page || active_admin_config.per_page
    end
    def index
      if(!params[:order])
        params[:order] = "email_asc"
      end
      super
    end
  end

end                                   
