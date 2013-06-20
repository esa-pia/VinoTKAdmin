ActiveAdmin.register Bouteille do

  # Create sections on the index screen
  scope :all, :default => true
  scope :rouge
  scope :blanc 
  scope :rose 
  scope :effervescent
  scope :alcool_digestif
  scope :aperitif
  scope :whisky 

  # Filterable attributes on the index screen
  filter :appellation
  filter :type, :as => :check_boxes, :collection => (Type.order.all)#.map{|o| [o.libelle, o.id]}
  filter :domaine, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Domaine.order.all)
  filter :cuvee, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Cuvee.order.all)#.map{|o| [o.libelle, o.id]}
  filter :format
  filter :millesime
  filter :prix
  filter :nouveau
  
  show do |bouteille|
    attributes_table do
      row :id
      row :appellation
      row :type do  |bouteille|
        status_tag(bouteille.type.libelle)
      end
      #row :type do
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
      f.input :domaine, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Domaine.order.all)#.map{|o| [o.libelle, o.id]}
      f.input :cuvee, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Cuvee.order.all)#.map{|o| [o.libelle, o.id]}
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
    column :appellation
    column :type, :sortable => 'types.libelle' do  |bouteille|
        status_tag(bouteille.type.libelle)
    end
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
  
  csv do
    column :id
    column :appellation
    column (:type)      { |bouteille| bouteille.type.libelle    }
    column (:domaine)   { |bouteille| bouteille.domaine.libelle }
    column (:cuvee)     { |bouteille| bouteille.cuvee.libelle   }
    column (:format)    { |bouteille| bouteille.format.valeur   }
    column (:millesime) { |bouteille| bouteille.format.valeur   }
    column :prix
    column :nouveau
  end
  
  controller do
    def scoped_collection
      end_of_association_chain.includes([:type, :domaine, :cuvee, :format, :millesime])
    end
    def per_page 
   		return max_csv_records if request.format == 'text/csv' ||  request.format == 'text/json'
   		return max_per_page if active_admin_config.paginate == false 
   		@per_page || active_admin_config.per_page 
 	end 
  end
end