ActiveAdmin.register Newsletter do
	menu :if => proc{ true }
 # Filterable attributes on the index screen
  filter :titre,      :label => I18n.t('newsletters.titre')
  filter :date_debut, :label => I18n.t('newsletters.date_debut')
  filter :date_fin,   :label => I18n.t('newsletters.date_fin')
  #filter :bouteilles, :label => I18n.t('catalogues.bouteilles'), :as => :select, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' ,   "data-no_results_text" => I18n.t('no_results_text') }, :collection => (Bouteille.order.all).map{|o| ["#{o.type.libelle} - #{o.appellation} - #{o.domaine.libelle} - #{o.cuvee.libelle} - #{o.volume.valeur}- #{o.millesime.valeur}", o.id]}
  
  index do |newsletter|
    selectable_column
    column I18n.t('newsletters.titre'), :titre
    column I18n.t('newsletters.date_debut'), :date_debut
    column I18n.t('newsletters.date_fin'), :date_fin
    #column  I18n.t('newsletters.nb_bouteille') do |catalogue|
    #  newsletter.bouteilles.count
    #end
    #column I18n.t('catalogues.image1'), :image1 do |catalogue|
    #  image_tag(catalogue.image1(:thumb)) if catalogue.image1
    #end
    column do |newsletter|
      link_to I18n.t('newsletters.send'), '#', :class => 'member_link send_newsletter', :pdf => send_newsletter_admin_newsletter_path(newsletter)
    end
    default_actions
    
  end
  show do |newsletter|
    panel I18n.t('newsletters.evenement_section_title') do
      attributes_table_for newsletter do
        row (I18n.t('newsletters.id')) {newsletter.id}
        row (I18n.t('newsletters.titre')) {newsletter.titre}
        row (I18n.t('newsletters.date_debut')) {newsletter.date_debut}
        row (I18n.t('newsletters.date_fin')) {newsletter.date_fin}
        row (I18n.t('newsletters.description')) {newsletter.description}
      end
    end
    if(newsletter.newsletters_bouteilles.count>0)
      panel I18n.t('newsletters.bouteille_section_title') do

        table_for newsletter.newsletters_bouteilles  do |t|
          t.column I18n.t('bouteilles.type'), :bouteille do  |newsletters_bouteille|
            status_tag(newsletters_bouteille.bouteille.type.libelle.parameterize)
          end
          t.column I18n.t('bouteilles.appellation'), :bouteille do  |newsletters_bouteille|
            newsletters_bouteille.bouteille.appellation
          end
          t.column I18n.t('bouteilles.domaine'), :bouteille do  |newsletters_bouteille|
            newsletters_bouteille.bouteille.domaine.libelle if newsletters_bouteille.bouteille.domaine_id?
          end
          t.column I18n.t('bouteilles.cuvee'), :bouteille do  |newsletters_bouteille|
            newsletters_bouteille.bouteille.cuvee.libelle if newsletters_bouteille.bouteille.cuvee_id?
          end
          t.column I18n.t('bouteilles.region'), :bouteille do  |newsletters_bouteille|
            newsletters_bouteille.bouteille.region.libelle if newsletters_bouteille.bouteille.region_id?
          end
          t.column I18n.t('bouteilles.format'), :bouteille do  |newsletters_bouteille|
            newsletters_bouteille.bouteille.volume.valeur if newsletters_bouteille.bouteille.volume_id?
          end
          t.column I18n.t('bouteilles.millesime'), :bouteille do  |newsletters_bouteille|
            newsletters_bouteille.bouteille.millesime.valeur if newsletters_bouteille.bouteille.millesime_id?
          end
          t.column I18n.t('bouteilles.prix'), :bouteille do |newsletters_bouteille|
            div :class => "prix" do
              number_to_currency newsletters_bouteille.bouteille.prix
            end
          end
          t.column I18n.t('newsletters.rabais'), :rabais do |newsletters_bouteille|
            div :class => "rabais" do
              "#{newsletters_bouteille.rabais} %"
            end
          end
          
        end
      end
    end
    panel I18n.t('newsletters.info_section_title') do
      attributes_table_for newsletter do
        row (I18n.t('newsletters.info')) {newsletter.info}
      end
    end
    active_admin_comments
  end

  form do |f|                         
    f.inputs I18n.t('newsletters.evenement_section_title') do       
      f.input :titre, :label => I18n.t('newsletters.titre')   
      f.input :date_debut , :label => I18n.t('newsletters.date_debut')  , :as => :just_datetime_picker             
      f.input :date_fin , :label => I18n.t('newsletters.date_fin')    , :as => :just_datetime_picker 
      f.input :description, :label => I18n.t('newsletters.description'), :input_html => { :rows => 4 }          
    end
    f.inputs I18n.t('newsletters.bouteille_section_title') , :id => "newsletters_bouteilles_section" do  
      f.has_many :newsletters_bouteilles do |ff|
        #ff.inputs
        ff.input :bouteille, :as => :select, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => I18n.t('newsletters.choose.bouteilles'),   "data-no_results_text" => I18n.t('no_results_text')  }, :collection => (Bouteille.order('type_id ASC , appellation ASC, domaine_id ASC, cuvee_id ASC').all).map{|o| [ "#{o.type.libelle} - #{o.appellation} - #{o.domaine.libelle} - #{o.cuvee.libelle} - #{o.volume.valeur}- #{o.millesime.valeur}", o.id]}
        ff.input :rabais,        :hint => "%" , :input_html => { :style => "width: 50px", :class => "spinner_percent"} 
        if ff.object.new_record?
          ff.action :cancel , label:  I18n.t('active_admin.has_many_delete'), :as => :link, :url => "#",
                 :wrapper_html => {:style => "display: none;"}
        else
          ff.input :_destroy, :as => :boolean, :wrapper_html => {:class => "has_many_remove button"}, 
          :label => I18n.t('active_admin.has_many_delete')
        end
      end    
    end
    f.inputs I18n.t('newsletters.info_section_title') do       
      f.input :info, :label => I18n.t('newsletters.info')     
    end                           
    f.actions                         
  end

  action_item :only => [:show] do
    link_to(I18n.t('active_admin.new_model', :model => active_admin_config.resource_label), new_resource_path)
  end
  
# -----------------------------------------------------------------------------------
  # Email sending
  
  action_item :only => :show do
    link_to I18n.t('newsletters.send'), send_newsletter_admin_newsletter_path(resource), :class => 'send_newsletter'
  end
  
  member_action :send_newsletter do
    @newsletter = Newsletter.find(params[:id])
    
    # Generate the PDF invoice if neccesary
    #generate_invoice(@invoice) if params[:attach_pdf]
    
    # Attach our own email if we want to send a copy to ourselves.
    #params[:recipients] += ", #{current_admin_user.email}" if params[:send_copy]
    
    # Send all emails
    Client.all.each do |client|
      NewsletterMailer.send_newsletter(@newsletter.id, client).deliver
    end
    
    # Change invoice status to sent
    #@invoice.status = Invoice::STATUS_SENT
    #@invoice.save
    
    redirect_to admin_newsletter_path(@newsletter), :notice => "newsletter sent succesfully"
  end

end
