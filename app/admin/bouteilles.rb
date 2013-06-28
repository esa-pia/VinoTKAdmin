ActiveAdmin.register Bouteille do

  # Create sections on the index screen
  scope (I18n.t('types.all')), :all, :default => true
  scope (I18n.t('types.rouge')), :rouge
  scope (I18n.t('types.blanc')), :blanc 
  scope (I18n.t('types.rose')), :rose 
  scope (I18n.t('types.effervescent')), :effervescent
  scope (I18n.t('types.alcool_digestif')), :alcool_digestif
  scope (I18n.t('types.aperitif')), :aperitif
  scope (I18n.t('types.whisky')), :whisky 

  # Filterable attributes on the index screen
  filter :appellation, :label => I18n.t('bouteilles.appellation')
  filter :type,        :label => I18n.t('bouteilles.type'),      :as => :check_boxes, :collection => (Type.order.all)#.map{|o| [o.libelle, o.id]}
  filter :domaine,     :label => I18n.t('bouteilles.domaine'),   :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Domaine.order.all)
  filter :cuvee,       :label => I18n.t('bouteilles.cuvee'),     :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Cuvee.order.all)#.map{|o| [o.libelle, o.id]}
  filter :format,      :label => I18n.t('bouteilles.format'),    :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }
  filter :millesime,   :label => I18n.t('bouteilles.millesime'), :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }
  filter :prix,        :label => I18n.t('bouteilles.prix')
  filter :nouveau,     :label => I18n.t('bouteilles.nouveau')
  
  #column I18n.t('clients.nom'), :nom
  index do |bouteille|
    selectable_column
    column I18n.t('bouteilles.type'), :type, :sortable => 'types.libelle' do  |bouteille|
        status_tag(bouteille.type.libelle.parameterize)
    end
    column I18n.t('bouteilles.appellation'), :appellation
    column I18n.t('bouteilles.domaine'), :domaine, :sortable => 'domaines.libelle'
    column I18n.t('bouteilles.cuvee'), :cuvee, :sortable => 'cuvees.libelle'
    column I18n.t('bouteilles.format'), :format, :sortable => 'formats.valeur'
    column I18n.t('bouteilles.millesime'), :millesime, :sortable => 'millesimes.valeur'
    column I18n.t('bouteilles.prix'), :prix, :sortable => :prix do |bouteille|
      div :class => "prix" do
        number_to_currency bouteille.prix
      end
    end
    column I18n.t('bouteilles.nouveau'), :nouveau, :sortable => :nouveau do  |bouteille|
      if(bouteille.nouveau)
        image_tag('/assets/new.png')
      end
    end
    default_actions
  end

  show do |bouteille|
    panel I18n.t('bouteilles.section_title') do
      attributes_table_for bouteille do
        row (I18n.t('bouteilles.id')) {bouteille.id}
        row (I18n.t('bouteilles.appellation')) {bouteille.appellation}
        row (I18n.t('bouteilles.type')) {status_tag(bouteille.type.libelle)}
        row (I18n.t('bouteilles.description')) {bouteille.description}
        row (I18n.t('bouteilles.domaine')) {bouteille.domaine}
        row (I18n.t('bouteilles.cuvee')) {bouteille.cuvee}
        row (I18n.t('bouteilles.format')) {bouteille.format}
        row (I18n.t('bouteilles.millesime')) {bouteille.millesime}
        row (I18n.t('bouteilles.prix')) {number_to_currency bouteille.prix}
        row (I18n.t('bouteilles.nouveau')) {bouteille.nouveau}
      end
    end
    active_admin_comments
  end
  
  form do |f|
    f.inputs I18n.t('bouteilles.section_title')do
      f.input :appellation, :label => I18n.t('bouteilles.appellation')
      f.input :type,        :label => I18n.t('bouteilles.type'),      :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Type.order.all)#.map{|o| [o.libelle, o.id]}
      f.input :domaine,     :label => I18n.t('bouteilles.domaine'),   :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Domaine.order.all)#.map{|o| [o.libelle, o.id]}
      f.input :cuvee,       :label => I18n.t('bouteilles.cuvee'),     :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Cuvee.order.all)#.map{|o| [o.libelle, o.id]}
      f.input :format,      :label => I18n.t('bouteilles.format'),    :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }
      f.input :millesime,   :label => I18n.t('bouteilles.millesime'), :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }
      f.input :description, :label => I18n.t('bouteilles.description')
      f.input :prix,        :label => I18n.t('bouteilles.prix')
      f.input :nouveau,     :label => I18n.t('bouteilles.nouveau')
    end
    f.buttons
  end
  
  
  # -----------------------------------------------------------------------------------
  # CSV
  csv do
    column :appellation
    column (:type)      { |bouteille| bouteille.type.libelle    }
    column (:domaine)   { |bouteille| bouteille.domaine.libelle }
    column (:cuvee)     { |bouteille| bouteille.cuvee.libelle   }
    column (:format)    { |bouteille| bouteille.format.valeur   }
    column (:millesime) { |bouteille| bouteille.format.valeur   }
    column :prix
    column :nouveau
  end
  
  # -----------------------------------------------------------------------------------
  # XLS
  xlsx(:i18n_scope => [:active_admin, :axlsx, :bouteilles],
       :header_style => {:bg_color => 'FF0000', :fg_color => 'FF' }) do

    # deleting columns from the report
    delete_columns :id, :created_at, :updated_at , :type, :domaine, :cuvee, :format, :description, :millesime  , :appellation, :prix, :nouveau

    column (:type)        { |bouteille| bouteille.type.libelle    }
    column (:appellation) { |bouteille| bouteille.appellation    }
    column (:domaine)     { |bouteille| bouteille.domaine.libelle }
    column (:cuvee)       { |bouteille| bouteille.cuvee.libelle   }
    column (:format)      { |bouteille| bouteille.format.valeur   }
    column (:millesime)   { |bouteille| bouteille.format.valeur   }
    column (:prix)        { |bouteille| bouteille.prix    }
    column (:nouveau)     { |bouteille| bouteille.nouveau    }
  end

  # -----------------------------------------------------------------------------------
  # CONTROLLER
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
   		return max_csv_records if request.format == 'text/csv' ||  request.format == 'text/json'  ||  request.format == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
   		return max_per_page if active_admin_config.paginate == false 
   		@per_page || active_admin_config.per_page 
   	end
  end
end