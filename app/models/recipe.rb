class Recipe < ActiveRecord::Base

  require "httparty"
  require "uri"
  has_and_belongs_to_many :users
  validates :api_id, presence: true



  def self.search(ingredient, allergies)
    ingredient = URI.escape(ingredient)
    allergy = allergies.values
    allergies_params = []
    allergy.each do |a|
      allergies_params << "allowedAllergy[]=#{a}" 
    end

    comb_allergies=allergies_params.join('&')

    base_url = "http://api.yummly.com/v1/api/recipes"
    app_id = "a60a3813"
    app_key = "03a140c9f2bc94ab668e30a025477217"

    url = "#{base_url}?_app_id=#{app_id}&_app_key=#{app_key}"

    HTTParty.get ("#{url}&q=#{ingredient}&#{comb_allergies}")
    end



end
