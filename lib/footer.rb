class Footer < ActiveAdmin::Component
  def build(*args)
    super(id: "footer")
    para I18n.t('copyright', :year => "#{Date.today.year}")
    #text_node render('shared/admin_footer')
  end
end