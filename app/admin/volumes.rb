ActiveAdmin.register Volume do
  menu :parent => I18n.t('menu.bouteilles_info')

  filter :valeur, :label => I18n.t('formats.valeur')

  index do
    selectable_column
    column I18n.t('formats.valeur'),:valeur
    default_actions
  end

  show do |format|
    panel I18n.t('formats.section_title') do
      attributes_table_for format do
        row (I18n.t('formats.id')) {format.id}
        row (I18n.t('formats.valeur')) {format.valeur}
      end
    end
    active_admin_comments
  end

  form do |f|                         
    f.inputs I18n.t('formats.section_title') do       
      f.input :valeur , :label => I18n.t('formats.valeur')
      f.input :bouteilles, :label => I18n.t('formats.bouteilles'), :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => I18n.t('formats.choose.bouteilles') ,   "data-no_results_text" => I18n.t('no_results_text') }, :collection => (Bouteille.order('type_id ASC , appellation ASC, domaine_id ASC, cuvee_id ASC').all).map{|o| [ "#{o.type.libelle} - #{o.appellation} - #{o.domaine.libelle} - #{o.cuvee.libelle} - #{o.volume.valeur}- #{o.millesime.valeur}", o.id]}
    end                               
    f.actions                         
  end

  action_item :only => [:show] do
    link_to(I18n.t('active_admin.new_model', :model => active_admin_config.resource_label), new_resource_path)
  end

  # -----------------------------------------------------------------------------------
  # XLS
  # xlsx(:i18n_scope => [:active_admin, :axlsx, :formats],
  #      :header_style => {:bg_color => 'FF0000', :fg_color => 'FF' }) do

  #   # deleting columns from the report
  #   delete_columns :id, :created_at, :updated_at

  #   # adding a column to the report
  #   #column(:valeur)
  # end
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
        params[:order] = "valeur_asc"
      end
      super
    end
  end
end

