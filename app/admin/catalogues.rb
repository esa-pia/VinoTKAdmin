ActiveAdmin.register Catalogue do
  
   # Filterable attributes on the index screen
  filter :titre
  #filter :bouteilles, :as => :check_boxes, :collection => (Bouteille.order.all)#.map{|o| [o.libelle, o.id]}
  
  show do |catalogue|
    attributes_table do
      row :id
      row :titre
      row "Nb bouteiles" do
        catalogue.bouteilles.count 
      end
      row :created_at
      row :updated_at
    end
    panel "Bouteilles" do
      table_for catalogue.bouteilles do |t|
        t.column :id
        t.column :appellation
        t.column :type
        t.column :domaine
        t.column :cuvee
        t.column :format
        t.column :millesime
        t.column :prix do |bouteille|
          number_to_currency bouteille.prix, :unit => "&euro;"
        end
        t.column :nouveau
      end
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
      f.input :bouteilles, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Bouteille.order.all).map{|o| [ "#{o.type.libelle} - #{o.appellation} - #{o.domaine.libelle} - #{o.cuvee.libelle} - #{o.format.valeur}- #{o.millesime.valeur}", o.id]}
      
      #f.input :bouteilles, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => option_groups_from_collection_for_select(Type.order.all, :bouteilles, :libelle, :id, :appellation, nil)
      
      f.input :image1, :as => :file, :hint => (f.template.image_tag(f.object.image1(:medium)) if f.object.image1)
      f.input :image2, :as => :file, :hint => (f.template.image_tag(f.object.image2(:medium)) if f.object.image2)
      f.input :image3, :as => :file, :hint => (f.template.image_tag(f.object.image3(:medium)) if f.object.image3)
      f.input :image4, :as => :file, :hint => (f.template.image_tag(f.object.image4(:medium)) if f.object.image4)
      f.input :image5, :as => :file, :hint => (f.template.image_tag(f.object.image5(:medium)) if f.object.image5)
      f.input :image6, :as => :file, :hint => (f.template.image_tag(f.object.image6(:medium)) if f.object.image6)
      
    end
    f.buttons
  end
  
  index do |catalogue|
    column :id
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
    default_actions
    column do |catalogue|
      a :href => generate_pdf_admin_catalogue_path(catalogue) do
        image_tag('/assets/pdf.png')
      end
    end
  end
  
  index :as => :grid, :columns => 5 do |catalogue|
    div do
      a :href => admin_catalogue_path(catalogue) do
        image_tag(catalogue.image1(:thumb))
      end
    end
    a truncate(catalogue.titre), :href => admin_catalogue_path(catalogue)
  end
  # -----------------------------------------------------------------------------------
  # PDF
  
  action_item :only => :show do
    link_to "Generer PDF", generate_pdf_admin_catalogue_path(resource)
  end
  member_action :generate_pdf do
    @catalogue = Catalogue.find(params[:id])
    generate_catalogue(@catalogue)
    
    # Send file to user
    send_file @catalogue.catalogue_location
  end
  
  
end

def generate_catalogue(catalogue)
  # Generate catalogue
  Prawn::Document.generate @catalogue.catalogue_location do |pdf|
    # Title
    pdf.image "#{Rails.root}/app/assets/images/logo.jpg", :width => 500
   # pdf.text "Catalogue ##{catalogue.id}", :size => 25
    pdf.move_down 20
    pdf.text catalogue.titre, :size => 30
    
    pdf.start_new_page

#    # Client info
#    pdf.text bouteille.type.libelle
#    pdf.text bouteille.domaine.libelle
#
#    #pdf.draw_text "#{t('.created_at')}: #{l(invoice.created_at, :format => :short)}", :at => [pdf.bounds.width / 2, pdf.bounds.height - 30]
#
#
#    # Our company info
#    # pdf.float do
#    #   pdf.bounding_box [0, pdf.bounds.top - 5], :width => pdf.bounds.width do
#    #     pdf.text invoice.client.company.name, :size => 20, :align => :right
#    #   end
#    # end
#

	if(catalogue.image1)
      pdf.image "#{Rails.root}/public#{catalogue.image1}".sub!(/\?.+\Z/, ''), :height => 200
      pdf.move_down 40
    end
    
    if(!"#{catalogue.image2}".eql?("/assets/missing.png"))
      pdf.image "#{Rails.root}/public#{catalogue.image2}".sub!(/\?.+\Z/, ''), :height => 200
      pdf.move_down 40
    end
    if(!"#{catalogue.image3}".eql?("/assets/missing.png"))
      pdf.image "#{Rails.root}/public#{catalogue.image3}".sub!(/\?.+\Z/, ''), :height => 200
      pdf.move_down 40
    end
    pdf.start_new_page
    
    
    # Items
    header = ['Appellation', 'Domaine', 'Cuvee', 'Format', 'Millesime', 'Prix']
    items = catalogue.bouteilles.collect do |bouteille|
      [bouteille.appellation, bouteille.domaine.libelle, bouteille.cuvee.libelle , bouteille.format.valeur,  bouteille.millesime.valeur,   bouteille.prix]
    end
    
    #items = items + [["", "", "Discount:", "#{number_with_delimiter(invoice.discount)}%"]] \
    #              + [["", "", "Sub-total:", "#{number_to_currency(invoice.subtotal)}"]] \
    #              + [["", "", "Taxes:", "#{number_to_currency(invoice.taxes)} (#{number_with_delimiter(invoice.tax)}%)"]] \
    #              + [["", "", "Total:", "#{number_to_currency(invoice.total)}"]]
    # 
    pdf.table [header] + items, :header => true, :width => pdf.bounds.width do
      row(-4..-1).borders = [:bottom, :top, :left, :right]
      row(-4..-1).border_width = 1
      row(-4..-1).column(3).align = :right
      row(-4..-1).column(4).align = :right
      row(-4..-1).column(5).align = :right
      row(0).style :font_style => :bold
      #row(-1).style :font_style => :bold
    end

    pdf.start_new_page
    
    if(!"#{catalogue.image4}".eql?("/assets/missing.png"))
      pdf.image "#{Rails.root}/public#{catalogue.image4}".sub!(/\?.+\Z/, ''), :height => 200
      pdf.move_down 40
    end
    if(!"#{catalogue.image5}".eql?("/assets/missing.png"))
      pdf.image "#{Rails.root}/public#{catalogue.image5}".sub!(/\?.+\Z/, ''), :height => 200
      pdf.move_down 40
    end
    if(!"#{catalogue.image6}".eql?("/assets/missing.png"))
      pdf.image "#{Rails.root}/public#{catalogue.image6}".sub!(/\?.+\Z/, ''), :height => 200
      pdf.move_down 40
    end

#    
#                     # :border_style => :grid, 
#                     # :headers => header, 
#                     # :width => pdf.bounds.width, 
#                     # :row_colors => %w{cccccc eeeeee},
#                     # :align => { 0 => :right, 1 => :left, 2 => :right, 3 => :right, 4 => :right }
#
#
#    # Terms
#    #if invoice.terms != ''
#    #  pdf.move_down 20
#    #  pdf.text 'Terms', :size => 18
#    #  pdf.text invoice.terms
#    #end

#
#    # Notes
#    #if invoice.notes != ''
#    #  pdf.move_down 20
#    #  pdf.text 'Notes', :size => 18
#    #  pdf.text invoice.notes
#    #end
#
    # Footer
#    num_pag=0 
#    pdf.footer [pdf.margin_box.left, pdf.margin_box.bottom + 25] do 
#      pdf.font "Helvetica" do 
#        pdf.stroke_horizontal_rule 
#        pdf.move_down 5 
#        pdf.text "PAGE FOOTER", :style => :bold, :size => 10 
#        pdf.move_up 12 
#        num_pag += 1 
#        pdf.text " - "+p+": Page "+num_pag.to_s+" of " + pdf.page_count.to_s, :align => :center, :size => 8, :align => :right 
#      end
#    end
    
    pdf.draw_text "fait le #{l(Time.now, :format => :short)}", :at => [0, 0]
  end
  
  

end
