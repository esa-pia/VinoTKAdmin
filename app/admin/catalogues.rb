require "open-uri"

ActiveAdmin.register Catalogue do

   # Filterable attributes on the index screen
  filter :titre, :label => I18n.t('catalogues.titre')
  filter :bouteilles, :label => I18n.t('catalogues.bouteilles'), :as => :select, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' ,   "data-no_results_text" => I18n.t('no_results_text') }, :collection => (Bouteille.order.all).map{|o| ["#{o.type.libelle} - #{o.appellation} - #{o.domaine.libelle} - #{o.cuvee.libelle} - #{o.volume.valeur}- #{o.millesime.valeur}", o.id]}
  
  index do |catalogue|
    selectable_column
    column I18n.t('catalogues.titre'), :titre
    column  I18n.t('catalogues.nb_bouteille') do |catalogue|
      catalogue.bouteilles.count
    end
    column I18n.t('catalogues.image1'), :image1 do |catalogue|
      image_tag(catalogue.image1(:thumb)) if catalogue.image1
    end
    column I18n.t('catalogues.image2'), :image2 do |catalogue|
      image_tag(catalogue.image2(:thumb)) if catalogue.image2
    end
    column I18n.t('catalogues.image3'), :image3 do |catalogue|
      image_tag(catalogue.image3(:thumb)) if catalogue.image3
    end
    column I18n.t('catalogues.image4'), :image4 do |catalogue|
      image_tag(catalogue.image4(:thumb)) if catalogue.image4
    end
    column I18n.t('catalogues.image5'), :image5 do |catalogue|
      image_tag(catalogue.image5(:thumb)) if catalogue.image5
    end
    column I18n.t('catalogues.image6'), :image6 do |catalogue|
      image_tag(catalogue.image6(:thumb)) if catalogue.image6
    end
    column do |catalogue|
      link_to I18n.translate("catalogue.generate.pdf"), '#', :class => 'member_link generatePDF', :pdf => generate_pdf_admin_catalogue_path(catalogue)
    end
    default_actions
    
  end
  
  index :as => :grid, :columns => 3 do |catalogue|
    resource_selection_cell catalogue
    div do
      a :href => admin_catalogue_path(catalogue) do
        if(!"#{catalogue.image1}".eql?("/assets/missing.png"))
          image_tag(catalogue.image1(:medium))
        else
           image_tag("/assets/logo.png", :style => "height: 159px;")
        end
      end
    end
    a truncate(catalogue.titre), :href => admin_catalogue_path(catalogue)
  end

  show do |catalogue|
    panel I18n.t('catalogues.section_title') do
      attributes_table_for catalogue do
        row (I18n.t('catalogues.id')) {catalogue.id}
        row (I18n.t('catalogues.titre')) {catalogue.titre}
        row (I18n.t('catalogues.nb_bouteille')) {catalogue.bouteilles.count}
      end
    end
    panel I18n.t('catalogues.bouteilles') do

      table_for catalogue.bouteilles.joins(:type).order('types.libelle ASC, appellation ASC, domaine_id ASC, cuvee_id ASC')  do |t|
        t.column I18n.t('bouteilles.nouveau'), :nouveau do  |bouteille|
          if(bouteille.nouveau)
            status_tag("new")
          end
        end
        t.column I18n.t('bouteilles.type'), :type do  |bouteille|
          status_tag(bouteille.type.libelle.parameterize, :style => 'background-color:' + bouteille.type.couleur + ';')
        end
        t.column I18n.t('bouteilles.appellation'), :appellation
        t.column I18n.t('bouteilles.domaine'), :domaine
        t.column I18n.t('bouteilles.cuvee'), :cuvee
        t.column I18n.t('bouteilles.region'), :region
        t.column I18n.t('bouteilles.format'), :volume
        t.column I18n.t('bouteilles.millesime'), :millesime
        t.column I18n.t('bouteilles.prix'), :prix do |bouteille|
          div :class => "prix" do
            number_to_currency bouteille.prix
          end
        end
        
      end

#      Type.all.each do |type|
#        bouteilleList = catalogue.bouteilles.order('appellation ASC, domaine_id ASC, cuvee_id ASC').where('type_id' => type.id)
#        if (bouteilleList.count>0)
#          table_for bouteilleList  do |t|
#            t.column :type do  |bouteille|
#              status_tag(bouteille.type.libelle.parameterize, :style => 'background-color:' + bouteille.type.couleur + ';')
#            end
#            t.column :appellation
#            t.column :domaine
#            t.column :cuvee
#            t.column :region
#            t.column :volume
#            t.column :millesime
#            t.column :prix do |bouteille|
#              div :class => "prix" do
#                number_to_currency bouteille.prix
#              end
#            end
#            t.column :nouveau do  |bouteille|
#              if(bouteille.nouveau)
#                image_tag('/assets/new.png')
#              end
#            end
#          end
#        end
#      end
    end
    panel I18n.t('catalogues.images') do
      table do
        thead do
          tr do
            th I18n.t('catalogues.image1')
            th I18n.t('catalogues.image2')
            th I18n.t('catalogues.image3')
            th I18n.t('catalogues.image4')
            th I18n.t('catalogues.image5')
            th I18n.t('catalogues.image6')
          end
        end
        tr do
          td image_tag(catalogue.image1(:thumb)) if catalogue.image1
          td image_tag(catalogue.image2(:thumb)) if catalogue.image2
          td image_tag(catalogue.image3(:thumb)) if catalogue.image3
          td image_tag(catalogue.image4(:thumb)) if catalogue.image4
          td image_tag(catalogue.image5(:thumb)) if catalogue.image5
          td image_tag(catalogue.image6(:thumb)) if catalogue.image6
        end
      end  
      
    end
    active_admin_comments
  end
  
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs I18n.t('catalogues.section_title') do
      f.input :titre, :label => I18n.t('catalogues.titre')#, :as => :select, :collection => (Type.order.all)#.map{|o| [o.libelle, o.id]}
      f.input :bouteilles, :label => I18n.t('catalogues.bouteilles'), :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => I18n.t('catalogues.choose.bouteilles'),   "data-no_results_text" => I18n.t('no_results_text')  }, :collection => (Bouteille.order('type_id ASC , appellation ASC, domaine_id ASC, cuvee_id ASC').all).map{|o| [ "#{o.type.libelle} - #{o.appellation} - #{o.domaine.libelle} - #{o.cuvee.libelle} - #{o.volume.valeur}- #{o.millesime.valeur}", o.id]}
      
      #f.input :bouteilles, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' ,   "data-no_results_text" => I18n.t('no_results_text') }, :collection => option_groups_from_collection_for_select(Type.order.all, :bouteilles, :libelle, :id, :appellation, nil)
      
      f.input :image1, :label => I18n.t('catalogues.image1'), :as => :file, :input_html => {:onchange => "readURL(event)"}, :hint => (f.template.image_tag(f.object.image1.url()) if f.object.image1)
      f.input :image2, :label => I18n.t('catalogues.image2'), :as => :file, :input_html => {:onchange => "readURL(event)"}, :hint => (f.template.image_tag(f.object.image2.url()) if f.object.image2)
      f.input :image3, :label => I18n.t('catalogues.image3'), :as => :file, :input_html => {:onchange => "readURL(event)"}, :hint => (f.template.image_tag(f.object.image3.url()) if f.object.image3)
      f.input :image4, :label => I18n.t('catalogues.image4'), :as => :file, :input_html => {:onchange => "readURL(event)"}, :hint => (f.template.image_tag(f.object.image4.url()) if f.object.image4)
      f.input :image5, :label => I18n.t('catalogues.image5'), :as => :file, :input_html => {:onchange => "readURL(event)"}, :hint => (f.template.image_tag(f.object.image5.url()) if f.object.image5)
      f.input :image6, :label => I18n.t('catalogues.image6'), :as => :file, :input_html => {:onchange => "readURL(event)"}, :hint => (f.template.image_tag(f.object.image6.url()) if f.object.image6)
      
    end
    f.buttons
  end
  action_item :only => [:show] do
    link_to(I18n.t('active_admin.new_model', :model => active_admin_config.resource_label), new_resource_path)
  end
  
  

  # -----------------------------------------------------------------------------------
  # XLS
  xlsx(:i18n_scope => [:active_admin, :axlsx, :catalogues],
       :header_style => {:bg_color => 'FF0000', :fg_color => 'FF' }) do

    # deleting columns from the report
    delete_columns :id, :created_at, :updated_at , :titre,  :bouteilles,
                   :image1_file_name, :image1_content_type, :image1_file_size, :image1_updated_at,
                   :image2_file_name, :image2_content_type, :image2_file_size, :image2_updated_at,
                   :image3_file_name, :image3_content_type, :image3_file_size, :image3_updated_at,
                   :image4_file_name, :image4_content_type, :image4_file_size, :image4_updated_at,
                   :image5_file_name, :image5_content_type, :image5_file_size, :image5_updated_at,
                   :image6_file_name, :image6_content_type, :image6_file_size, :image6_updated_at

    column (:titre)        { |catalogue| catalogue.titre }
    column (:nb)           { |catalogue| catalogue.bouteilles.count }
  end
  # -----------------------------------------------------------------------------------
  # PDF
  
  action_item :only => :show do
    link_to I18n.translate("catalogue.generate.pdf"), '#', :class => 'generatePDF', :pdf => generate_pdf_admin_catalogue_path(resource)
  end
  member_action :generate_pdf do
    @catalogue = Catalogue.find(params[:id])
    generate_catalogue(@catalogue)
    
    # Send file to user
    send_file @catalogue.catalogue_location
    cookies[:fileDownload] = true
    cookies[:path]= "/"
  end
  controller do
    def per_page 
   		return max_csv_records if request.format == 'text/csv' ||  request.format == 'application/json' ||  request.format == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
   		return max_per_page if active_admin_config.paginate == false 
   		@per_page || active_admin_config.per_page 
 	end
    def index
      if(!params[:order])
        params[:order] = "id_asc"
      end
      super
    end
  end
  
end
def image_nouveau(nouveau)
  if(nouveau)
    {:image => "#{Rails.root}/app/assets/images/new.png", :image_height => 22, :image_width => 22}
  else
    ""
  end
end
def generate_catalogue(catalogue)
  # Generate catalogue
  Prawn.debug = true
  Prawn::Document.generate @catalogue.catalogue_location,  :left_margin => 40, :right_margin => 40, :top_margin=> 50, :bottom_margin => 50 do |pdf|
    # Title
    pdf.move_down 30
    pdf.image "#{Rails.root}/app/assets/images/logo.png", :width => 325
   # pdf.text "Catalogue ##{catalogue.id}", :size => 25
    pdf.move_down 70
    pdf.text catalogue.titre, :size => 40
    
    pdf.start_new_page

#    # Our company info
#    # pdf.float do
#    #   pdf.bounding_box [0, pdf.bounds.top - 5], :width => pdf.bounds.width do
#    #     pdf.text invoice.client.company.name, :size => 20, :align => :right
#    #   end
#    # end
#
	if((!"#{catalogue.image1}".eql?("/assets/missing.png"))||(!"#{catalogue.image2}".eql?("/assets/missing.png"))||(!"#{catalogue.image2}".eql?("/assets/missing.png")))
      if(!"#{catalogue.image1}".eql?("/assets/missing.png"))
        pdf.image open("#{catalogue.image1}".sub!(/\?.+\Z/, '')), :height => 200
        pdf.move_down 40
      end
      if(!"#{catalogue.image2}".eql?("/assets/missing.png"))
        pdf.image open("#{catalogue.image2}".sub!(/\?.+\Z/, '')), :height => 200
        pdf.move_down 40
      end
      if(!"#{catalogue.image3}".eql?("/assets/missing.png"))
        pdf.image open("#{catalogue.image3}".sub!(/\?.+\Z/, '')), :height => 200
        pdf.move_down 40
      end
      pdf.start_new_page
    end
    
    
    # Items

    header = ["", I18n.t('bouteilles.appellation'), I18n.t('bouteilles.domaine'), I18n.t('bouteilles.cuvee'), 
              I18n.t('bouteilles.format'), I18n.t('bouteilles.millesime'), I18n.t('bouteilles.prix')]


    Type.all.each do |type|
      items = catalogue.bouteilles.order('appellation ASC, domaine_id ASC, cuvee_id ASC').where('type_id' => type.id).collect do |bouteille|
        [image_nouveau(bouteille.nouveau), bouteille.appellation, bouteille.domaine.libelle, bouteille.cuvee.libelle , bouteille.volume.valeur,  bouteille.millesime.valeur,   "#{ActionController::Base.helpers.number_to_currency(bouteille.prix)}"]
      end
      logger.debug items
      if(items.count>0)
        pdf.text "#{type.libelle}", :size => 18
        pdf.move_down 10
        pdf.font_size 8
        Prawn.debug = true
        pdf.table [header] + items, :header => true, :width => pdf.bounds.width, :row_colors => %w{e0e0e0 f0f0f0} do
          row(-4..-1).borders = [:bottom, :top]
          column(0).borders = [:left, :bottom, :top]
          column(1).borders = [:right,:bottom, :top ]
          column(2).borders = [:right,:bottom, :top ]
          column(3).borders = [:right,:bottom, :top ]
          column(4).borders = [:right,:bottom, :top ]
          column(5).borders = [:right,:bottom, :top ]
          column(6).borders = [:right,:bottom, :top ]
          row(-4..-1).border_width = 1
          row(-200..-1).column(4).align = :right
          row(-200..-1).column(5).align = :right
          row(-200..-1).column(6).align = :right
          row(0).style :font_style => :bold
          column(0).padding = 1
          column(1).padding_left = 0
          column(6).padding_right = 10
          
          column(0).width = 26
          column(1).width = 110
          column(2).width = 125

          column(4).width = 38
          column(5).width = 48
          column(6).width = 52
          
          #row(-1).style :font_style => :bold
        end
        pdf.move_down 20
        pdf.font_size 12
      end
    end

    pdf.start_new_page
    if((!"#{catalogue.image4}".eql?("/assets/missing.png"))||(!"#{catalogue.image5}".eql?("/assets/missing.png"))||(!"#{catalogue.image6}".eql?("/assets/missing.png")))
      if(!"#{catalogue.image4}".eql?("/assets/missing.png"))
        pdf.image open("#{catalogue.image4}".sub!(/\?.+\Z/, '')), :height => 200
        pdf.move_down 40
      end
      if(!"#{catalogue.image5}".eql?("/assets/missing.png"))
        pdf.image open("#{catalogue.image5}".sub!(/\?.+\Z/, '')), :height => 200
        pdf.move_down 40
      end
      if(!"#{catalogue.image6}".eql?("/assets/missing.png"))
        pdf.image open("#{catalogue.image6}".sub!(/\?.+\Z/, '')), :height => 200
        pdf.move_down 40
      end
      pdf.start_new_page
    end

    pdf.fill_color "e30014"
    pdf.fill_rectangle [pdf.bounds.right-220, pdf.bounds.bottom+110 ], 220, 110
    pdf.fill_color "FFFFFF"

    pdf.draw_text I18n.t('vinotk.name'),         :at => [pdf.bounds.right-210, pdf.bounds.bottom+90]
    pdf.draw_text I18n.t('vinotk.address'),    :at => [pdf.bounds.right-210, pdf.bounds.bottom+70]
    pdf.draw_text I18n.t('vinotk.city'),     :at => [pdf.bounds.right-210, pdf.bounds.bottom+50]
    pdf.draw_text I18n.t('vinotk.phone'),  :at => [pdf.bounds.right-210, pdf.bounds.bottom+30]

    pdf.image open("http://maps.googleapis.com/maps/api/staticmap?size=220x178&maptype=roadmap&markers=color:0xcd150e%7Clabel:S%7C48.850892,2.3923963&sensor=false"), :height => 89, :at => [pdf.bounds.right-120, pdf.bounds.bottom+100]


    # Footer
    pdf.page_count.times do |i|
      pdf.go_to_page(i+1)
      pdf.fill_color "e30014"
      pdf.fill_rectangle [pdf.bounds.left-40, pdf.bounds.bottom-10 ], pdf.bounds.right+80, pdf.bounds.bottom+40

      pdf.fill_color "FFFFFF"
      pdf.draw_text "page #{i+1} / #{pdf.page_count}", :at => [pdf.bounds.right-55, pdf.bounds.bottom-35]

    end
    # Header
    pdf.page_count.times do |i|
      pdf.go_to_page(i+1)
      pdf.fill_color "e30014"
      pdf.fill_rectangle [pdf.bounds.left-40, pdf.bounds.top+50 ], pdf.bounds.right+80, pdf.bounds.bottom+40
      if(i>=1)
        pdf.fill_color "FFFFFF"
        pdf.draw_text "#{catalogue.titre}", :at => [pdf.bounds.left, pdf.bounds.top+26]
      end
    end

    pdf.draw_text "fait le #{l(Time.now, :format => :short)}", :at => [0, -35]
  end
  
  

end
