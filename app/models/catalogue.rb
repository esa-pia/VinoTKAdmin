#require 'file_attacher'

class Catalogue < ActiveRecord::Base
  attr_accessible :titre, :bouteille_ids, :image1, :image2, :image3, :image4, :image5, :image6
  has_many :catalogues_bouteilles
  has_many :bouteilles , :through => :catalogues_bouteilles
  
  has_attached_file :image1, :default_url => "/assets/missing.png", :styles => { :medium => "238x238>", 
                                   :thumb => "60x60>"
                                 },:storage => :ftp, :path => "/vinotkAdmin/:attachment/:id/:style/:filename", :url => "http://esampaio.free.fr/vinotkAdmin/:attachment/:id/:style/:filename",:ftp_servers => [{
        :host     => "ftpperso.free.fr",
        :user     => "esampaio",
        :password => "thditfq",
        :passive  => true
      }
    ]
  has_attached_file :image2, :default_url => "/assets/missing.png", :styles => { :medium => "238x238>", 
                                   :thumb => "60x60>"
                                 },:storage => :ftp, :path => "/vinotkAdmin/:attachment/:id/:style/:filename", :url => "http://esampaio.free.fr/vinotkAdmin/:attachment/:id/:style/:filename",:ftp_servers => [{
        :host     => "ftpperso.free.fr",
        :user     => "esampaio",
        :password => "thditfq",
        :passive  => true
      }
    ]
  has_attached_file :image3, :default_url => "/assets/missing.png", :styles => { :medium => "238x238>", 
                                   :thumb => "60x60>"
                                 },:storage => :ftp, :path => "/vinotkAdmin/:attachment/:id/:style/:filename", :url => "http://esampaio.free.fr/vinotkAdmin/:attachment/:id/:style/:filename",:ftp_servers => [{
        :host     => "ftpperso.free.fr",
        :user     => "esampaio",
        :password => "thditfq",
        :passive  => true
      }
    ]

  has_attached_file :image4, :default_url => "/assets/missing.png", :styles => { :medium => "238x238>", 
                                   :thumb => "60x60>"
                                 },:storage => :ftp, :path => "/vinotkAdmin/:attachment/:id/:style/:filename", :url => "http://esampaio.free.fr/vinotkAdmin/:attachment/:id/:style/:filename",:ftp_servers => [{
        :host     => "ftpperso.free.fr",
        :user     => "esampaio",
        :password => "thditfq",
        :passive  => true
      }
    ]

  has_attached_file :image5, :default_url => "/assets/missing.png", :styles => { :medium => "238x238>", 
                                   :thumb => "60x60>"
                                 },:storage => :ftp, :path => "/vinotkAdmin/:attachment/:id/:style/:filename", :url => "http://esampaio.free.fr/vinotkAdmin/:attachment/:id/:style/:filename",:ftp_servers => [{
        :host     => "ftpperso.free.fr",
        :user     => "esampaio",
        :password => "thditfq",
        :passive  => true
      }
    ]

  has_attached_file :image6, :default_url => "/assets/missing.png", :styles => { :medium => "238x238>", 
                                   :thumb => "60x60>"
                                 },:storage => :ftp, :path => "/vinotkAdmin/:attachment/:id/:style/:filename", :url => "http://esampaio.free.fr/vinotkAdmin/:attachment/:id/:style/:filename",:ftp_servers => [{
        :host     => "ftpperso.free.fr",
        :user     => "esampaio",
        :password => "thditfq",
        :passive  => true
      }
    ]

  def display_name
    titre
  end
  
  def catalogue_location
    "#{Rails.root}/pdfs/catalogue-#{self.id}.pdf"
  end
end
