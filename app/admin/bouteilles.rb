ActiveAdmin.register Bouteille do
  
  filter :appellation
  filter :type#_id, :as => :select, :collection => (Type.order.all)#.map{|o| [o.libelle, o.id]}
  filter :domaine
  filter :cuvee
  filter :format
  filter :millesime
  filter :prix
  filter :nouveau
  
  show do |bouteille|
    attributes_table do
      row :id
      row :appellation
      row :type #do
        #link_to bouteille.type.libelle, admin_type_path(bouteille.type.id) 
      #end
      row :description
      row :domaine
      row :cuvee
      row :format
      row :millesime
      row :prix do
        number_to_currency bouteille.prix, :unit => "&euro;"
      end
      row :nouveau
      row :created_at
      row :updated_at
      
    end
    active_admin_comments
  end
  
  form do |f|
    f.inputs do
      f.input :type#, :as => :select, :collection => (Type.order.all)#.map{|o| [o.libelle, o.id]}
      f.input :domaine
      f.input :cuvee
      f.input :format
      f.input :millesime
      f.input :appellation
      f.input :description
      f.input :prix
      f.input :nouveau
    end
    f.buttons
  end
  
  index do |bouteille|
    column :id
    column :appellation
    column :type, :sortable => 'types.libelle'
    column :domaine, :sortable => 'domaines.libelle'
    column :cuvee, :sortable => 'cuvees.libelle'
    column :format, :sortable => 'formats.valeur'
    column :millesime, :sortable => 'millesimes.valeur'
    column :prix, :sortable => :prix do |bouteille|
      number_to_currency bouteille.prix, :unit => "&euro;"
    end
    column :nouveau
    default_actions
  end
  
  controller do
    def scoped_collection
      end_of_association_chain.includes([:type, :domaine, :cuvee, :format, :millesime])
    end
  end
  
end
