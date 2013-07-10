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
    panel I18n.t('newsletters.section_title') do
      attributes_table_for newsletter do
        row (I18n.t('newsletters.id')) {newsletter.id}
        row (I18n.t('newsletters.titre')) {newsletter.titre}
        row (I18n.t('newsletters.date_debut')) {newsletter.date_debut}
        row (I18n.t('newsletters.date_fin')) {newsletter.date_fin}
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
    f.inputs I18n.t('newsletters.bouteille_section_title') do  
      f.has_many :newsletters_bouteilles ,  :header => "Display this as the H3" , :label => "Display this as the H4"do |ff|
        #ff.inputs
        ff.input :bouteille, :as => :select, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' ,   "data-no_results_text" => I18n.t('no_results_text') }, :collection => (Bouteille.order.all).map{|o| ["#{o.type.libelle} - #{o.appellation} - #{o.domaine.libelle} - #{o.cuvee.libelle} - #{o.volume.valeur}- #{o.millesime.valeur}", o.id]}
        ff.input :rabais,        :input_html => { :style => "width: 50px", :class => "spinner"} 
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
