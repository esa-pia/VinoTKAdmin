class ClientsController < InheritedResources::Base


  def unsubscribe
    @client = Client.find(params[:id])
    if(@client.nil?)
    	@message = I18n.t("newsletters.unsubscribe")
    else
    	@client.inactif = true
    	@client.save()
    	@message = I18n.t("newsletters.unsubscribe")
    end
  end
end
