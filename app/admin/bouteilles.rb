ActiveAdmin.register Bouteille do

  # Create sections on the index screen
  scope (I18n.t('types.all')), :all, :default => true
  Type.all.each do |type|
    scope type.libelle do |items|
      items.where(:type_id => type.id)
    end
  end
 

  # Filterable attributes on the index screen
  filter :appellation,    :label => I18n.t('bouteilles.appellation')
  filter :type,           :label => I18n.t('bouteilles.type'),      :as => :check_boxes, :collection => (Type.order.all)#.map{|o| [o.libelle, o.id]}
  filter :domaine_in,     :label => I18n.t('bouteilles.domaine'),   :as => :select, :input_html => { :class => 'filter-chzn-select', :width => 'auto', "data-placeholder" => I18n.t('bouteilles.choose.domaine'), "data-no_results_text" => I18n.t("no_results_text")   , "multiple" => "multiple" },  :collection => (Domaine.order("lower(libelle) ASC").all)
  filter :cuvee_in,       :label => I18n.t('bouteilles.cuvee'),     :as => :select, :input_html => { :class => 'filter-chzn-select', :width => 'auto', "data-placeholder" => I18n.t('bouteilles.choose.cuvee'), "data-no_results_text" => I18n.t("no_results_text")     , "multiple" => "multiple" },  :collection => (Cuvee.order("lower(libelle) ASC").all)#.map{|o| [o.libelle, o.id]}
  filter :region_in,      :label => I18n.t('bouteilles.region'),    :as => :select, :input_html => { :class => 'filter-chzn-select', :width => 'auto', "data-placeholder" => I18n.t('bouteilles.choose.region'), "data-no_results_text" => I18n.t('no_results_text')    , "multiple" => "multiple" },  :collection => (Region.order("lower(libelle) ASC").all)#.map{|o| [o.libelle, o.id]}
  filter :volume_in,      :label => I18n.t('bouteilles.format'),    :as => :select, :input_html => { :class => 'filter-chzn-select', :width => 'auto', "data-placeholder" => I18n.t('bouteilles.choose.format'), "data-no_results_text" => I18n.t('no_results_text')    , "multiple" => "multiple" },  :collection => (Volume.order("lower(valeur) ASC").all)
  filter :millesime_in,   :label => I18n.t('bouteilles.millesime'), :as => :select, :input_html => { :class => 'filter-chzn-select', :width => 'auto', "data-placeholder" => I18n.t('bouteilles.choose.millesime'), "data-no_results_text" => I18n.t('no_results_text') , "multiple" => "multiple" },  :collection => (Millesime.order("lower(valeur) ASC").all)
  filter :prix,           :label => I18n.t('bouteilles.prix'),      :as => :numeric_range
  filter :nouveau,        :label => I18n.t('bouteilles.nouveau')
  
  #column I18n.t('clients.nom'), :nom
  index do |bouteille|
    selectable_column
    column I18n.t('bouteilles.nouveau'), :nouveau, :sortable => :nouveau do  |bouteille|
      if(bouteille.nouveau)
         status_tag("new")
      end
    end
    column I18n.t('bouteilles.type'), :type, :sortable => 'types.libelle' do  |bouteille|
        status_tag(bouteille.type.libelle.parameterize, :style => 'background-color:' + bouteille.type.couleur + ';')
    end
    column I18n.t('bouteilles.appellation'), :appellation
    column I18n.t('bouteilles.domaine'), :domaine, :sortable => 'domaines.libelle'
    column I18n.t('bouteilles.cuvee'), :cuvee, :sortable => 'cuvees.libelle'
    column I18n.t('bouteilles.region'), :region, :sortable => 'regions.libelle'
    column I18n.t('bouteilles.format'), :volume, :sortable => 'volumes.valeur'
    column I18n.t('bouteilles.millesime'), :millesime, :sortable => 'millesimes.valeur'
    column I18n.t('bouteilles.prix'), :prix, :sortable => :prix do |bouteille|
      div :class => "prix" do
        number_to_currency bouteille.prix
      end
    end
    
    default_actions
  end

  show do |bouteille|
    panel I18n.t('bouteilles.section_title') do
      attributes_table_for bouteille do
        row (I18n.t('bouteilles.id')) {bouteille.id}
        row (I18n.t('bouteilles.appellation')) {bouteille.appellation}
        row (I18n.t('bouteilles.type')) {status_tag(bouteille.type.libelle.parameterize, :style => 'background-color:' + bouteille.type.couleur + ';')}
        row (I18n.t('bouteilles.description')) {bouteille.description}
        row (I18n.t('bouteilles.domaine')) {bouteille.domaine}
        row (I18n.t('bouteilles.cuvee')) {bouteille.cuvee}
        row (I18n.t('bouteilles.region')) {bouteille.region}
        row (I18n.t('bouteilles.format')) {bouteille.volume}
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
      f.input :type,        :label => I18n.t('bouteilles.type'),        :input_html => { :class => 'chzn-select-type',      :width => 'auto', "data-placeholder" => I18n.t('bouteilles.choose.type') ,      "data-no_results_text" => I18n.t('no_results_text'), "data-create_option_text" => I18n.t("types.create.new")}, :collection => (Type.order("lower(libelle) ASC").all)#.map{|o| [o.libelle, o.id]}
      f.input :domaine,     :label => I18n.t('bouteilles.domaine'),     :input_html => { :class => 'chzn-select-domaine',   :width => 'auto', "data-placeholder" => I18n.t('bouteilles.choose.domaine') ,   "data-no_results_text" => I18n.t('no_results_text'), "data-create_option_text" => I18n.t("domaines.create.new") }, :collection => (Domaine.order("lower(libelle) ASC").all)#.map{|o| [o.libelle, o.id]}
      f.input :cuvee,       :label => I18n.t('bouteilles.cuvee'),       :input_html => { :class => 'chzn-select-cuvee',     :width => 'auto', "data-placeholder" => I18n.t('bouteilles.choose.cuvee'),      "data-no_results_text" => I18n.t('no_results_text'), "data-create_option_text" => I18n.t("cuvees.create.new") }, :collection => (Cuvee.order("lower(libelle) ASC").all)#.map{|o| [o.libelle, o.id]}
      f.input :region,      :label => I18n.t('bouteilles.region'),      :input_html => { :class => 'chzn-select-region',    :width => 'auto', "data-placeholder" => I18n.t('bouteilles.choose.region'),     "data-no_results_text" => I18n.t('no_results_text'), "data-create_option_text" => I18n.t("regions.create.new") }, :collection => (Region.order("lower(libelle) ASC").all)#.map{|o| [o.libelle, o.id]}
      f.input :volume,      :label => I18n.t('bouteilles.format'),      :input_html => { :class => 'chzn-select-format',    :width => 'auto', "data-placeholder" => I18n.t('bouteilles.choose.format') ,    "data-no_results_text" => I18n.t('no_results_text'), "data-create_option_text" => I18n.t("formats.create.new") }, :collection => (Volume.order("lower(valeur) ASC").all)#.map{|o| [o.valeur, o.id]}
      f.input :millesime,   :label => I18n.t('bouteilles.millesime'),   :input_html => { :class => 'chzn-select-millesime', :width => 'auto', "data-placeholder" => I18n.t('bouteilles.choose.millesime'),  "data-no_results_text" => I18n.t('no_results_text'), "data-create_option_text" => I18n.t("millesimes.create.new") }, :collection => (Millesime.order("lower(valeur) ASC").all)#.map{|o| [o.valeur, o.id]}
      f.input :description, :label => I18n.t('bouteilles.description'), :input_html => { :rows => 4 }
      f.input :prix,        :label => I18n.t('bouteilles.prix'),        :input_html => { :style => "width: 50px"} ,        :hint =>I18n.t('number.currency.format.unit')
      f.input :nouveau,     :label => I18n.t('bouteilles.nouveau')
    end
    f.buttons
  end
  
  action_item :only => [:show] do
    link_to(I18n.t('active_admin.new_model', :model => active_admin_config.resource_label), new_resource_path)
  end
  
  batch_action :creer_catalogue do |selection|
    @catalogue = Catalogue.new
    @catalogue.titre = "titre"
    Bouteille.find(selection).each do |bouteille|
      @catalogue.bouteilles << bouteille
    end
    @catalogue.save
    redirect_to edit_admin_catalogue_path(@catalogue) , :notice => I18n.t('catalogues.creer')
  end
  batch_action :creer_newsletter do |selection|
    @newsletter = Newsletter.new
    @newsletter.titre = "titre"
    Bouteille.find(selection).each do |bouteille|
      @newslettersBouteille = NewslettersBouteille.new
      @newslettersBouteille.bouteille = bouteille
      @newsletter.newsletters_bouteilles << @newslettersBouteille
      @newslettersBouteille.save
    end
    @newsletter.save
    redirect_to edit_admin_newsletter_path(@newsletter) , :notice => I18n.t('newsletters.creer')
  end
  # -----------------------------------------------------------------------------------
  # CSV
  csv do
    column :appellation
    column (:type)      { |bouteille| bouteille.type.libelle    }
    column (:domaine)   { |bouteille| bouteille.domaine.libelle }
    column (:cuvee)     { |bouteille| bouteille.cuvee.libelle   }
    column (:region)    { |bouteille| bouteille.region.libelle   }
    column (:volume)    { |bouteille| bouteille.volume.valeur   }
    column (:millesime) { |bouteille| bouteille.millesime.valeur   }
    column :prix
    column :nouveau
  end
  
  # -----------------------------------------------------------------------------------
  # XLS
  # xlsx(:i18n_scope => [:active_admin, :axlsx, :bouteilles],
  #      :header_style => {:bg_color => 'FF0000', :fg_color => 'FF' }) do

  #   # deleting columns from the report
  #   delete_columns :id, :created_at, :updated_at , :type, :domaine, :cuvee, :region, :volume, :description, :millesime  , :appellation, :prix, :nouveau

  #   column (:type)        { |bouteille| bouteille.type.libelle    }
  #   column (:appellation) { |bouteille| bouteille.appellation    }
  #   column (:domaine)     { |bouteille| bouteille.domaine.libelle }
  #   column (:cuvee)       { |bouteille| bouteille.cuvee.libelle   }
  #   column (:region)      { |bouteille| bouteille.region.libelle if bouteille.region   }
  #   column (:volume)      { |bouteille| bouteille.volume.valeur   }
  #   column (:millesime)   { |bouteille| bouteille.millesime.valeur   }
  #   column (:prix)        { |bouteille| bouteille.prix    }
  #   column (:nouveau)     { |bouteille| bouteille.nouveau    }
  # end

  # -----------------------------------------------------------------------------------
  # CONTROLLER
  controller do
    def scoped_collection
      end_of_association_chain.includes([:type, :domaine, :cuvee, :region, :volume, :millesime])
    end
    def index
      if(!params[:order])
        params[:order] = "types.libelle_asc"
      end
      super
    end
    def per_page 
   		return max_csv_records #if request.format == 'text/csv' ||  request.format == 'text/json'  ||  request.format == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
   		#return max_per_page if active_admin_config.paginate == false 
   		#@per_page || active_admin_config.per_page 
   	end
  end
end