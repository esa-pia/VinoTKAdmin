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
  filter :format, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }
  filter :millesime, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }
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
        number_to_currency bouteille.prix
      end
      row :nouveau
      row :created_at
      row :updated_at
      
    end
    active_admin_comments
  end
  
  form do |f|
    f.inputs do
      f.input :type, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Type.order.all)#.map{|o| [o.libelle, o.id]}
      f.input :domaine, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Domaine.order.all)#.map{|o| [o.libelle, o.id]}
      f.input :cuvee, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Cuvee.order.all)#.map{|o| [o.libelle, o.id]}
      f.input :format, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }
      f.input :millesime, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }
      f.input :appellation
      f.input :description
      f.input :prix
      f.input :nouveau
    end
    f.buttons
  end
  
  index do |bouteille|
    selectable_column
    column :type, :sortable => 'types.libelle' do  |bouteille|
        status_tag(bouteille.type.libelle.parameterize)
    end
    column :appellation
    column :domaine, :sortable => 'domaines.libelle'
    column :cuvee, :sortable => 'cuvees.libelle'
    column :format, :sortable => 'formats.valeur'
    column :millesime, :sortable => 'millesimes.valeur'
    column :prix, :sortable => :prix do |bouteille|
      div :class => "prix" do
        number_to_currency bouteille.prix
      end
    end
    column :nouveau do  |bouteille|
      if(bouteille.nouveau)
        image_tag('/assets/new.png')
      end
    end
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
    def index
      if(!params[:order])
        params[:order] = "types.libelle_asc"
      end
      super
    end
    def per_page 
   		return max_csv_records if request.format == 'text/csv' ||  request.format == 'text/json'
   		return max_per_page if active_admin_config.paginate == false 
   		@per_page || active_admin_config.per_page 
 	end 
  end
end