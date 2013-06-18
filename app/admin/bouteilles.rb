ActiveAdmin.register Bouteille do

  # Create sections on the index screen
  scope :all, :default => true
  scope :rouge
  scope :blanc 
  scope :rose 
  scope :effervescent
  scope :alcool_digestif
  scope :aperitif
  scope :whisky 

  # Filterable attributes on the index screen
  filter :appellation
  filter :type, :as => :check_boxes, :collection => (Type.order.all)#.map{|o| [o.libelle, o.id]}
  filter :domaine, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Domaine.order.all)
  filter :cuvee, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Cuvee.order.all)#.map{|o| [o.libelle, o.id]}
  filter :format
  filter :millesime
  filter :prix
  filter :nouveau
  
  show do |bouteille|
    attributes_table do
      row :id
      row :appellation
      row :type #do
        #link_to bouteille.type.libelle, admin_type_path(bouteille.type.id) 
      #end
      row :description
      row :domaine
      row :cuvee
      row :format
      row :millesime
      row :prix do
        number_to_currency bouteille.prix, :unit => "&euro;"
      end
      row :nouveau
      row :created_at
      row :updated_at
      
    end
    active_admin_comments
  end
  
  form do |f|
    f.inputs do
      f.input :type#, :as => :select, :collection => (Type.order.all)#.map{|o| [o.libelle, o.id]}
      f.input :domaine, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Domaine.order.all)#.map{|o| [o.libelle, o.id]}
      f.input :cuvee, :input_html => { :class => 'chzn-select', :width => 'auto', "data-placeholder" => 'Click' }, :collection => (Cuvee.order.all)#.map{|o| [o.libelle, o.id]}
      f.input :format
      f.input :millesime
      f.input :appellation
      f.input :description
      f.input :prix
      f.input :nouveau
    end
    f.buttons
  end
  
  index do |bouteille|
    column :id
    column :appellation
    column :type, :sortable => 'types.libelle'
    column :domaine, :sortable => 'domaines.libelle'
    column :cuvee, :sortable => 'cuvees.libelle'
    column :format, :sortable => 'formats.valeur'
    column :millesime, :sortable => 'millesimes.valeur'
    column :prix, :sortable => :prix do |bouteille|
      number_to_currency bouteille.prix, :unit => "&euro;"
    end
    column :nouveau
    default_actions
    
    
    
  end
  
  csv do
    column :id
    column :appellation
    column (:type)      { |bouteille| bouteille.type.libelle    }
    column (:domaine)   { |bouteille| bouteille.domaine.libelle }
    column (:cuvee)     { |bouteille| bouteille.cuvee.libelle   }
    column (:format)    { |bouteille| bouteille.format.valeur   }
    column (:millesime) { |bouteille| bouteille.format.valeur   }
    column :prix
    column :nouveau
  end
  
  controller do
    def scoped_collection
      end_of_association_chain.includes([:type, :domaine, :cuvee, :format, :millesime])
    end
    def per_page 
   		return max_csv_records if request.format == 'text/csv' ||  request.format == 'text/json'
   		return max_per_page if active_admin_config.paginate == false 
   		@per_page || active_admin_config.per_page 
 	end 
  end
  
  #index :download_links => false, :as => :table, :default => true do 
  #    if params[:pag].blank?
  #      div link_to(I18n.t("text_for_the_link"), 'mymodel?pag=1', :class => "class_for_link")
  #     else
  #      div link_to(I18n.t("print.print"), 'mymodel', :class => "class_for_link")                     
  #    end
  #    # other code
  #  end
  
  
  
  # -----------------------------------------------------------------------------------
  # PDF
  
  #action_item :only => :show do
  #  link_to "Generate PDF", generate_pdf_admin_bouteille_path(resource)
  #end
  
  #member_action :generate_pdf do
  #  @bouteille = Bouteille.find(params[:id])
  #  generate_bouteille(@bouteille)
  #  
  #  # Send file to user
  #  send_file @bouteille.bouteille_location
  #end
  
end




#def generate_bouteille(bouteille)
#  # Generate bouteille
#  Prawn::Document.generate @bouteille.bouteille_location do |pdf|
#    # Title
#    pdf.text "Invoice ##{bouteille.id}", :size => 25
#
#    # Client info
#    pdf.text bouteille.appellation
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
#    pdf.move_down 20
#
#    # Items
#    #header = ['Qty.', 'Description', 'Amount', 'Total']
#    #items = invoice.items.collect do |item|
#    #  [item.quantity.to_s, item.description, number_to_currency(item.amount), number_to_currency(item.total)]
#    #end
#    
#    #items = items + [["", "", "Discount:", "#{number_with_delimiter(invoice.discount)}%"]] \
#    #              + [["", "", "Sub-total:", "#{number_to_currency(invoice.subtotal)}"]] \
#    #              + [["", "", "Taxes:", "#{number_to_currency(invoice.taxes)} (#{number_with_delimiter(invoice.tax)}%)"]] \
#    #              + [["", "", "Total:", "#{number_to_currency(invoice.total)}"]]
#    # 
#    #pdf.table [header] + items, :header => true, :width => pdf.bounds.width do
#    #  row(-4..-1).borders = []
#    #  row(-4..-1).column(2).align = :right
#    #  row(0).style :font_style => :bold
#    #  row(-1).style :font_style => :bold
#    #end
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
#    # Footer
#    pdf.draw_text "Generated at #{l(Time.now, :format => :short)}", :at => [0, 0]
#  end
#  
#  
#
#end
