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
    column  I18n.t('newsletters.nb_promotion') do |newsletter|
      newsletter.newsletters_bouteilles.count
    end
    column do |newsletter|
      link_to I18n.t('newsletters.send'), '#', :class => 'member_link send_newsletter', :pdf => send_newsletter_admin_newsletter_path(newsletter)
    end
    default_actions
  end

  show do |newsletter|
    panel I18n.t('newsletters.section_title') do
      attributes_table_for newsletter do
        row (I18n.t('newsletters.id')) {newsletter.id}
        row (I18n.t('newsletters.statut')) {status_tag(newsletter.statut)}
        row (I18n.t('newsletters.titre')) {newsletter.titre}
        row (I18n.t('newsletters.description')) {raw(newsletter.description)}
      end
    end
    
    if(newsletter.newsletters_bouteilles.count>0)
      panel I18n.t('newsletters.bouteille_section_title') do
        attributes_table_for newsletter do
          row (I18n.t('newsletters.promotions_titre')) {newsletter.promotions_titre}
        end
        if(newsletter.produit_phares.count>0)
          panel I18n.t('newsletters.produit_phare_section_title') do   
            attributes_table_for newsletter do 
              row (I18n.t("bouteilles.cuvee") ) { newsletter.produit_phares.first().bouteille.cuvee.libelle }
              row (I18n.t("bouteilles.appellation") ) { newsletter.produit_phares.first().bouteille.appellation }
              row (I18n.t("bouteilles.type") ) {   status_tag(newsletter.produit_phares.first().bouteille.type.libelle.parameterize, :style => 'background-color:' + newsletter.produit_phares.first().bouteille.type.couleur + ';')}
              row (I18n.t("bouteilles.format") ) { newsletter.produit_phares.first().bouteille.volume.valeur }
              row (I18n.t("bouteilles.millesime") ) { newsletter.produit_phares.first().bouteille.millesime.valeur }
              row (I18n.t("bouteilles.prix") ) { number_to_currency newsletter.produit_phares.first().prix }
              row (I18n.t("newsletters.rabais") ) { "#{newsletter.produit_phares.first().rabais} %" }
              row (I18n.t("newsletters.nouveau_prix") ) { number_to_currency newsletter.produit_phares.first().nouveau_prix }
              row (I18n.t("newsletters.evenement_image") ) { image_tag(newsletter.produit_phares.first().image(:thumb)) if newsletter.produit_phares.first().image }
              row (I18n.t("newsletters.description")) { raw(newsletter.produit_phares.first().description) }
            end
          end
        end
        table_for newsletter.newsletters_bouteilles.order(:position)  do |t|
          #t.column :id
          #t.column :position
          t.column I18n.t('bouteilles.type'), :bouteille do  |newsletters_bouteille|
            status_tag(newsletters_bouteille.bouteille.type.libelle.parameterize, :style => 'background-color:' + newsletters_bouteille.bouteille.type.couleur + ';')
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
          t.column I18n.t('newsletters.nouveau_prix'), :bouteille do |newsletters_bouteille|
            div :class => "prix" do
              number_to_currency (newsletters_bouteille.nouveau_prix)
            end
          end
        end
      end
    end
    if(newsletter.evenements.count>0)
      panel I18n.t('newsletters.evenement_section_title') do
        table_for newsletter.evenements.order(:position)  do |t|
        #  t.column :id
        #  t.column :position
          t.column (I18n.t('newsletters.titre_evenement')), :titre do  |evenement| evenement.titre end
          t.column (I18n.t('newsletters.evenement_image')), :image do  |evenement| image_tag(evenement.image(:thumb)) if evenement.image end
          t.column (I18n.t('newsletters.date_debut')), :date_debut do  |evenement| I18n.l(evenement.date_debut, format: :time) if evenement.date_debut? end
          t.column (I18n.t('newsletters.date_fin')),   :date_fin   do  |evenement| I18n.l(evenement.date_fin, format: :time) if evenement.date_fin? end
          t.column (I18n.t('newsletters.evenement_description')), :description   do  |evenement| raw(evenement.description) end
        end
      end
    end
    panel I18n.t('newsletters.info_section_title') do
      attributes_table_for newsletter do
        row (I18n.t('newsletters.info')) {newsletter.info}
        row (I18n.t('newsletters.info_description')) {raw(newsletter.info_description)}
      end
    end
    active_admin_comments
  end

  form do |f|   
    f.inputs I18n.t('newsletters.section_title') do       
      f.input :titre, :label => I18n.t('newsletters.titre')  
      f.input :description, :label => I18n.t('newsletters.description') , :wrapper_html => { :class => "cleared" }     
    end                      
    
    f.inputs I18n.t('newsletters.bouteille_section_title') , :id => "newsletters_bouteilles_section" do  
      f.input :promotions_titre  , :label => I18n.t('newsletters.promotions_titre')

      f.has_many  :produit_phares, :name => "Produit Phare", :id => "produit_phare" do |pf|
        pf.input :bouteille, :as => :select,                       :input_html => { :class => 'bouteille-chzn-select', :width => 'auto', "data-placeholder" => I18n.t('newsletters.choose.produit_phare'),   "data-no_results_text" => I18n.t('no_results_text')  }, :collection => (Bouteille.joins(:type, :domaine, :cuvee, :volume, :millesime).order('types.libelle ASC , appellation ASC, domaines.libelle ASC, cuvees.libelle ASC').all).map{|o| [ "#{o.type.libelle} - #{o.appellation} - #{o.domaine.libelle} - #{o.cuvee.libelle} - #{o.volume.valeur} - #{o.millesime.valeur}", o.id]}
        pf.input :prix,         :disabled => "true", label: false, :hint =>I18n.t('number.currency.format.unit'), :input_html => { :style => "text-align: right;color:white;background-color: rgba(225, 0, 19, 0.4);margin-right: -12px;border-style: none;font-size: 15px;text-decoration: line-through;width: 45px;"}
        pf.input :rabais,        :hint => "%" ,                    :input_html => { :style => "width: 40px", :class => "spinner_percent"} 
        pf.input :nouveau_prix, :disabled => "true", label: false, :hint =>I18n.t('number.currency.format.unit'), :input_html => { :style => "text-align: right;color:white;background-color: rgba(225, 0, 19, 1);margin-right: -12px;border-style: none;font-size: 15px;width: 45px;"}
        pf.input :image, :label => I18n.t('newsletters.evenement_image'), :as => :file, :input_html => {:onchange => "readURL(event)"}, :hint => (pf.template.image_tag(pf.object.image.url(:medium )) if pf.object.image),  :wrapper_html => {:class => "image_section"}  
        pf.input :description, :label => I18n.t('newsletters.evenement_description'), :wrapper_html => { :class => "cleared description_section" }
        if pf.object.new_record?
          pf.action :cancel , label:  I18n.t('active_admin.has_many_delete'), :as => :link, :url => "#",
                 :wrapper_html => {:style => "display: none;"}
        else
          pf.input :_destroy, :as => :boolean, :wrapper_html => {:class => "has_many_remove button"}, 
          :label => I18n.t('active_admin.has_many_delete')
        end
      end   
  
      f.has_many :newsletters_bouteilles , :sortable => :position do |ff|
        #ff.inputs
        ff.input :position
        ff.input :bouteille, :as => :select,                       :input_html => { :class => 'bouteille-chzn-select', :width => 'auto', "data-placeholder" => I18n.t('newsletters.choose.bouteilles'),   "data-no_results_text" => I18n.t('no_results_text')  }, :collection => (Bouteille.joins(:type, :domaine, :cuvee, :volume, :millesime).order('types.libelle ASC , appellation ASC, domaines.libelle ASC, cuvees.libelle ASC').all).map{|o| [ "#{o.type.libelle} - #{o.appellation} - #{o.domaine.libelle} - #{o.cuvee.libelle} - #{o.volume.valeur} - #{o.millesime.valeur}", o.id]}
        ff.input :prix,         :disabled => "true", label: false, :hint =>I18n.t('number.currency.format.unit'), :input_html => { :style => "text-align: right;color:white;background-color: rgba(225, 0, 19, 0.4);margin-right: -12px;border-style: none;font-size: 15px;text-decoration: line-through;width: 45px;"}
        ff.input :rabais,        :hint => "%" ,                    :input_html => { :style => "width: 40px", :class => "spinner_percent"} 
        ff.input :nouveau_prix, :disabled => "true", label: false, :hint =>I18n.t('number.currency.format.unit'), :input_html => { :style => "text-align: right;color:white;background-color: rgba(225, 0, 19, 1);margin-right: -12px;border-style: none;font-size: 15px;width: 45px;"}
        if ff.object.new_record?
          ff.action :cancel , label:  I18n.t('active_admin.has_many_delete'), :as => :link, :url => "#",
                 :wrapper_html => {:style => "display: none;"}
        else
          ff.input :_destroy, :as => :boolean, :wrapper_html => {:class => "has_many_remove button"}, 
          :label => I18n.t('active_admin.has_many_delete')
        end
      end    
    end
    f.inputs I18n.t('newsletters.evenement_section_title') , :id => "newsletters_evenements_section" do  
     f.has_many :evenements , :sortable => :position do |fff|
      fff.input :position
      fff.input :titre  , :label => I18n.t('newsletters.titre_evenement')
      fff.input :image, :label => I18n.t('newsletters.evenement_image'), :as => :file, :input_html => {:onchange => "readURL(event)"}, :hint => (fff.template.image_tag(fff.object.image.url(:thumb)) if fff.object.image),  :wrapper_html => {:class => "image_section"}  
      fff.input :date_debut , :label => I18n.t('newsletters.date_debut')  , :as => :just_datetime_picker, :wrapper_html => {:class => "date_debut_section"}        
      fff.input :date_fin , :label => I18n.t('newsletters.date_fin')    , :as => :just_datetime_picker ,:wrapper_html => {:class => "date_fin_section"}
      fff.input :description, :label => I18n.t('newsletters.evenement_description'), :wrapper_html => { :class => "cleared description_section" }
      if fff.object.new_record?
          fff.action :cancel , label:  I18n.t('active_admin.has_many_delete'), :as => :link, :url => "#",
                 :wrapper_html => {:style => "display: none;"}
        else
          fff.input :_destroy, :as => :boolean, :wrapper_html => {:class => "has_many_remove button"}, 
          :label => I18n.t('active_admin.has_many_delete')
        end        
     end
    end
    f.inputs I18n.t('newsletters.info_section_title') do       
      f.input :info, :label => I18n.t('newsletters.info') 
      f.input :info_description, :label => I18n.t('newsletters.info_description') , :wrapper_html => { :class => "cleared" }     
    end                           
    f.actions                         
  end

  action_item :only => [:show] do
    link_to(I18n.t('active_admin.new_model', :model => active_admin_config.resource_label), new_resource_path)
  end
  action_item :only => [:show] do
    link_to I18n.t('newsletters.voir'), see_path(resource, Client.find(1)), target: "_blank"
  end
# -----------------------------------------------------------------------------------
  # Email sending
  
  action_item :only => :show do
    link_to I18n.t('newsletters.send'), send_newsletter_admin_newsletter_path(resource), :class => 'send_newsletter'
  end
  action_item :only => :show do
    link_to I18n.t('newsletters.send_me'), send_me_newsletter_admin_newsletter_path(resource), :class => 'send_newsletter'
  end
  
  


  member_action :send_newsletter do
    @newsletter = Newsletter.find(params[:id])
    
    # Generate the PDF invoice if neccesary
    #generate_invoice(@invoice) if params[:attach_pdf]
    
    # Attach our own email if we want to send a copy to ourselves.
    #params[:recipients] += ", #{current_admin_user.email}" if params[:send_copy]
    
    # Send all emails
    Client.where( :inactif => false).all.each do |client|
      NewsletterMailer.send_newsletter(@newsletter, client).deliver
    end
    
    # Change invoice status to sent
    #@invoice.status = Invoice::STATUS_SENT
    #@invoice.save
    
    redirect_to admin_newsletter_path(@newsletter), :notice => I18n.t("newsletters.envoi_ok")
  end
  member_action :send_me_newsletter do
    @newsletter = Newsletter.find(params[:id])
    NewsletterMailer.send_newsletter(@newsletter, current_admin_user).deliver
    redirect_to admin_newsletter_path(@newsletter), :notice => I18n.t("newsletters.envoi_ok")
  end
end
