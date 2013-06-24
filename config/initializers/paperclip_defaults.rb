Paperclip::Attachment.default_options.merge!(
         :storage => :ftp,
         :path => "/vinotkAdmin/:attachment/:id/:style/:filename",
         :url => "http://esampaio.free.fr/vinotkAdmin/:attachment/:id/:style/:filename",
         :default_url => "/assets/missing.png",
         :ftp_servers => [{
                           :host     => "ftpperso.free.fr",
                           :user     => "esampaio",
                           :password => "thditfq",
                           :passive  => true
                          }])