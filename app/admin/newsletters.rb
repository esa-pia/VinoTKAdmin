ActiveAdmin.register Newsletter do
	menu :if => proc{ false }
 # Filterable attributes on the index screen
  filter :titre,      :label => I18n.t('newsletters.titre')
  filter :date_debut, :label => I18n.t('newsletters.date_debut')
  filter :date_fin,   :label => I18n.t('newsletters.date_fin')
  #filter :bouteilles, :label => I18n.t('catalogues.bouteilles'), :as => :select, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Bouteille.order.all).map{|o| ["#{o.type.libelle} - #{o.appellation} - #{o.domaine.libelle} - #{o.cuvee.libelle} - #{o.format.valeur}- #{o.millesime.valeur}", o.id]}
  
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
      a :href => '#', :url => send_newsletter_admin_newsletter_path(newsletter), :class => 'sendPDF' do
        image_tag('/assets/send.png')
      end
    end
    default_actions
    
  end

# -----------------------------------------------------------------------------------
  # Email sending
  
  action_item :only => :show do
    link_to "Envoyer", send_newsletter_admin_newsletter_path(resource), :class => 'send_newsletter'
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
