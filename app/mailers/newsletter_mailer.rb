class NewsletterMailer < ActionMailer::Base
  default from: "News letter Vino - TK <no-reply@vinotk-paris.fr>"


  def send_newsletter(newsletter_id, client)
    @client = client;
    @url = "www.google.com"#edit_client_url(client)
    mail(to: "#{@client.prenom} #{@client.nom} <#{@client.email}>", subject: "Bienvenue !")
  end

end
