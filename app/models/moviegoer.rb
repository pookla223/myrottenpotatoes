class Moviegoer < ActiveRecord::Base
  attr_accessible :uid, :provider, :name # see text for explanation
  def self.create_with_omniauth(auth)
    has_many :reviews
    has_many :movies, :through => :reviews
    Moviegoer.create!(
      :provider => auth["provider"],
      :uid => auth["uid"],
      :name => auth["info"]["name"])
  end
end
