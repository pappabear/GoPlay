class Venue < ActiveRecord::Base


  validates_presence_of :name
  validates_presence_of :address1
  validates_presence_of :city
  validates_presence_of :state


end
