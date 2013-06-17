ActiveAdmin.register Domaine do
  
  index do
    column :id
    column :libelle
    default_actions
  end
  
  controller do
    def per_page 
   		return max_csv_records if request.format == 'text/csv' ||  request.format == 'application/json'
   		return max_per_page if active_admin_config.paginate == false 
   		@per_page || active_admin_config.per_page 
 	end 
  end
end
