ActiveAdmin.register Cuvee   do
  menu :parent => I18n.t('menu.bouteilles_info') , :label => proc{I18n.t('menu.cuvees')}

  filter :libelle, :label => I18n.t('cuvees.libelle')

  index do
    selectable_column
    column I18n.t('cuvees.libelle'),:libelle
    default_actions
  end

  show do |cuvee|
    panel I18n.t('cuvees.section_title') do
      attributes_table_for cuvee do
        row (I18n.t('cuvees.id')) {cuvee.id}
        row (I18n.t('cuvees.libelle')) {cuvee.libelle}
      end
    end
    active_admin_comments
  end

  form do |f|                         
    f.inputs I18n.t('cuvees.section_title') do       
      f.input :libelle , :label => I18n.t('cuvees.libelle')
      f.input :bouteilles, :label => I18n.t('cuvees.bouteilles'), :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => I18n.t('cuvees.choose.bouteilles') }, :collection => (Bouteille.order('type_id ASC , appellation ASC, domaine_id ASC, cuvee_id ASC').all).map{|o| [ "#{o.type.libelle} - #{o.appellation} - #{o.domaine.libelle} - #{o.cuvee.libelle} - #{o.volume.valeur}- #{o.millesime.valeur}", o.id]}
    end                               
    f.actions                         
  end

  action_item :only => [:show] do
    link_to(I18n.t('active_admin.new_model', :model => active_admin_config.resource_label), new_resource_path)
  end

  
  # -----------------------------------------------------------------------------------
  # XLS
  xlsx(:i18n_scope => [:active_admin, :axlsx, :cuvees],
       :header_style => {:bg_color => 'FF0000', :fg_color => 'FF' }) do

    # deleting columns from the report
    delete_columns :id, :created_at, :updated_at

    # adding a column to the report
    #column(:libelle)
  end
  # -----------------------------------------------------------------------------------
  # CONTROLLER
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
