class NewsletterMailer < ActionMailer::Base
  default from: "News letter Vino - TK <no-reply@vinotk-paris.fr>"


  def send_newsletter(newsletter, client)
    @client = client;
    @newsletter = newsletter;
    if(@client.instance_of?(Client))
      mail(to: "#{@client.prenom} #{@client.nom} <#{@client.email}>", subject: @newsletter.titre)
    else
      mail(to: "#{@client.email}", subject: @newsletter.titre)
    end
  end

end
