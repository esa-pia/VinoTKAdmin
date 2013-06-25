class Client < ActiveRecord::Base
  attr_accessible :nom, :prenom , :email

  validates :email, :presence => true, :uniqueness => true  , :email => true
  validates :nom, :presence => true
  validates :prenom, :presence => true
end
