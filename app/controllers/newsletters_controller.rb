class NewslettersController < InheritedResources::Base

  def see
  	@newsletter = Newsletter.find(params[:id])
    @client = Client.find(params[:clientid])
  end
end
