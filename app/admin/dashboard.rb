ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }
  
  sidebar I18n.t('catalogues.last')  do
    Catalogue.order('created_at desc').first(1).map do |last_catalogue|
      div do
        a :href => admin_catalogue_path(last_catalogue) do
          image_tag(last_catalogue.image1(:medium))
        end
      end
      a truncate(last_catalogue.titre), :href => admin_catalogue_path(last_catalogue)
    end
  end

  sidebar I18n.t('clients.last') do
    table_for Client.order('created_at desc').order('nom ASC, prenom ASC').first(5)  do |t|
      t.column I18n.t('clients.nom'), :nom
      t.column I18n.t('clients.prenom'), :prenom
    end
  end
  content :title => proc{ I18n.t("active_admin.dashboard") } do
    #div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #  span :class => "blank_slate" do
    #    span I18n.t("active_admin.dashboard_welcome.welcome")
    #    small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #  end
    #end
    
    columns do

      column :id => 'bouteille-new' do
        panel I18n.t('bouteilles.new') do
          table_for Bouteille.order('created_at desc').where(:nouveau => true).joins(:type).order('types.libelle ASC, appellation ASC, domaine_id ASC, cuvee_id ASC')  do |t|
            t.column I18n.t('bouteilles.type'), :type do  |bouteille|
              status_tag(bouteille.type.libelle.parameterize)
            end
            t.column I18n.t('bouteilles.appellation'), :appellation do  |bouteille|
              link_to bouteille.appellation, admin_bouteille_path(bouteille)
            end
            t.column I18n.t('bouteilles.domaine'), :domaine
            t.column I18n.t('bouteilles.cuvee'), :cuvee
            t.column I18n.t('bouteilles.format'), :volume
            t.column I18n.t('bouteilles.millesime'), :millesime
            t.column I18n.t('bouteilles.prix'), :prix do |bouteille|
              div :class => "prix" do
                number_to_currency bouteille.prix
              end
            end
          end
        end
      end
    end
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content

  
end
