require "open-uri"

ActiveAdmin.register Catalogue do

   # Filterable attributes on the index screen
  filter :titre
  filter :bouteilles, :as => :select, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Bouteille.order.all).map{|o| ["#{o.type.libelle} - #{o.appellation} - #{o.domaine.libelle} - #{o.cuvee.libelle} - #{o.format.valeur}- #{o.millesime.valeur}", o.id]}
  #, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Bouteille.order('type_id ASC , appellation ASC, domaine_id ASC, cuvee_id ASC').all).map{|o| [ , o.id]}
  show do |catalogue|
    attributes_table do
      row :titre
      row "Nb bouteiles" do
        catalogue.bouteilles.count 
      end
      row :created_at
      row :updated_at
    end
    panel "Bouteilles" do

      table_for catalogue.bouteilles.joins(:type).order('types.libelle ASC, appellation ASC, domaine_id ASC, cuvee_id ASC')  do |t|
        t.column :type do  |bouteille|
          status_tag(bouteille.type.libelle.parameterize)
        end
        t.column :appellation
        t.column :domaine
        t.column :cuvee
        t.column :format
        t.column :millesime
        t.column :prix do |bouteille|
          div :class => "prix" do
            number_to_currency bouteille.prix
          end
        end
        t.column :nouveau do  |bouteille|
          if(bouteille.nouveau)
            image_tag('/assets/new.png')
          end
        end
      end

#      Type.all.each do |type|
#        bouteilleList = catalogue.bouteilles.order('appellation ASC, domaine_id ASC, cuvee_id ASC').where('type_id' => type.id)
#        if (bouteilleList.count>0)
#          table_for bouteilleList  do |t|
#            t.column :type do  |bouteille|
#              status_tag(bouteille.type.libelle.parameterize)
#            end
#            t.column :appellation
#            t.column :domaine
#            t.column :cuvee
#            t.column :format
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
    panel "Images" do
      attributes_table_for catalogue do
        row :image1 do |catalogue|
          image_tag(catalogue.image1(:thumb)) if catalogue.image1
        end
        row :image2 do |catalogue|
          image_tag(catalogue.image2(:thumb)) if catalogue.image2
        end
        row :image3 do |catalogue|
          image_tag(catalogue.image3(:thumb)) if catalogue.image3
        end
        row :image4 do |catalogue|
          image_tag(catalogue.image4(:thumb)) if catalogue.image4
        end
        row :image5 do |catalogue|
          image_tag(catalogue.image5(:thumb)) if catalogue.image5
        end
        row :image6 do |catalogue|
          image_tag(catalogue.image6(:thumb)) if catalogue.image6
        end
      end
    end
    active_admin_comments
  end
  
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :titre#, :as => :select, :collection => (Type.order.all)#.map{|o| [o.libelle, o.id]}
      f.input :bouteilles, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Bouteille.order('type_id ASC , appellation ASC, domaine_id ASC, cuvee_id ASC').all).map{|o| [ "#{o.type.libelle} - #{o.appellation} - #{o.domaine.libelle} - #{o.cuvee.libelle} - #{o.format.valeur}- #{o.millesime.valeur}", o.id]}
      
      #f.input :bouteilles, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => option_groups_from_collection_for_select(Type.order.all, :bouteilles, :libelle, :id, :appellation, nil)
      
      f.input :image1, :as => :file, :input_html => {:onchange => "readURL(event)"}, :hint => (f.template.image_tag(f.object.image1.url()) if f.object.image1)
      f.input :image2, :as => :file, :input_html => {:onchange => "readURL(event)"}, :hint => (f.template.image_tag(f.object.image2.url()) if f.object.image2)
      f.input :image3, :as => :file, :input_html => {:onchange => "readURL(event)"}, :hint => (f.template.image_tag(f.object.image3.url()) if f.object.image3)
      f.input :image4, :as => :file, :input_html => {:onchange => "readURL(event)"}, :hint => (f.template.image_tag(f.object.image4.url()) if f.object.image4)
      f.input :image5, :as => :file, :input_html => {:onchange => "readURL(event)"}, :hint => (f.template.image_tag(f.object.image5.url()) if f.object.image5)
      f.input :image6, :as => :file, :input_html => {:onchange => "readURL(event)"}, :hint => (f.template.image_tag(f.object.image6.url()) if f.object.image6)
      
    end
    f.buttons
  end
  
  index do |catalogue|
    selectable_column
    column :titre
    column "nb bouteille" do |catalogue|
      catalogue.bouteilles.count
    end
    column :image1 do |catalogue|
      image_tag(catalogue.image1(:thumb)) if catalogue.image1
    end
    column :image2 do |catalogue|
      image_tag(catalogue.image2(:thumb)) if catalogue.image2
    end
    column :image3 do |catalogue|
      image_tag(catalogue.image3(:thumb)) if catalogue.image3
    end
    column :image4 do |catalogue|
      image_tag(catalogue.image4(:thumb)) if catalogue.image4
    end
    column :image5 do |catalogue|
      image_tag(catalogue.image5(:thumb)) if catalogue.image5
    end
    column :image6 do |catalogue|
      image_tag(catalogue.image6(:thumb)) if catalogue.image6
    end
    column do |catalogue|
      a :href => generate_pdf_admin_catalogue_path(catalogue), :class => 'generatePDF' do
        image_tag('/assets/pdf.png')
      end
    end
    default_actions
    
  end
  
  index :as => :grid, :columns => 3 do |catalogue|
    div do
      a :href => admin_catalogue_path(catalogue) do
        image_tag(catalogue.image1(:medium))
      end
    end
    a truncate(catalogue.titre), :href => admin_catalogue_path(catalogue)
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
    link_to I18n.translate("catalogue.generate.pdf"), generate_pdf_admin_catalogue_path(resource)
  end
  member_action :generate_pdf do
    @catalogue = Catalogue.find(params[:id])
    generate_catalogue(@catalogue)
    
    # Send file to user
    send_file @catalogue.catalogue_location
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

def generate_catalogue(catalogue)
  # Generate catalogue
  Prawn::Document.generate @catalogue.catalogue_location,  :left_margin => 40, :right_margin => 40, :top_margin=> 50, :bottom_margin => 50 do |pdf|
    # Title
    pdf.move_down 30
    pdf.image "#{Rails.root}/app/assets/images/logo.jpg", :width => 325
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

    header = ['Appellation', 'Domaine', 'Cuvee', 'Format', 'Millesime', 'Prix']


    Type.all.each do |type|
      items = catalogue.bouteilles.order('appellation ASC, domaine_id ASC, cuvee_id ASC').where('type_id' => type.id).collect do |bouteille|
        [bouteille.appellation, bouteille.domaine.libelle, bouteille.cuvee.libelle , bouteille.format.valeur,  bouteille.millesime.valeur,   "#{ActionController::Base.helpers.number_to_currency(bouteille.prix)}"]
      end
      if(items.count>0)
        pdf.text "#{type.libelle}", :size => 18
        pdf.move_down 10
        pdf.font_size 8
        pdf.table [header] + items, :header => true, :width => pdf.bounds.width, :row_colors => %w{e0e0e0 f0f0f0} do
          row(-4..-1).borders = [:bottom, :top, :left, :right]
          row(-4..-1).border_width = 1
          row(-200..-1).column(3).align = :right
          row(-200..-1).column(4).align = :right
          row(-200..-1).column(5).align = :right
          row(0).style :font_style => :bold
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

    pdf.draw_text "Vino - TK",         :at => [pdf.bounds.right-210, pdf.bounds.bottom+90]
    pdf.draw_text "2 rue Guenot",    :at => [pdf.bounds.right-210, pdf.bounds.bottom+70]
    pdf.draw_text "75011 Paris",     :at => [pdf.bounds.right-210, pdf.bounds.bottom+50]
    pdf.draw_text "01 43 71 76 06",  :at => [pdf.bounds.right-210, pdf.bounds.bottom+30]

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
