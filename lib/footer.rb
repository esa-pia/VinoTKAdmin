class Footer < ActiveAdmin::Component
  def build(*args)
    super(id: "footer")
    para "Copyright #{Date.today.year} Eric Sampaio"
    #text_node render('shared/admin_footer')
  end
end