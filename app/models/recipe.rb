class Recipe < ActiveRecord::Base

  require "httparty"
  require "uri"
  has_and_belongs_to_many :users
  validates :api_id, presence: true



  def self.search(ingredient, allergy)
    ingredient = URI.escape(ingredient)
    allergy = URI.escape(allergy)
    base_url = "http://api.yummly.com/v1/api/recipes"
    app_id = "a60a3813"
    app_key = "03a140c9f2bc94ab668e30a025477217"

    url = "#{base_url}?_app_id=#{app_id}&_app_key=#{app_key}"

    HTTParty.get ("#{url}&q=#{ingredient}&allowedAllergy[]=396^#{allergy}")
    end



end
