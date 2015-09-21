class Recipe < ActiveRecord::Base
require "httparty"
belongs_to :user
  validates :title, presence: true

  before_save :default_values

  def self.search(ingredient)

    base_url = "http://api.yummly.com/v1/api/recipes"
    app_id = "a60a3813"
    app_key = "03a140c9f2bc94ab668e30a025477217"

    url = "#{base_url}?_app_id=#{app_id}&_app_key=#{app_key}"

    HTTParty.get ("#{url}&q=#{ingredient}")

    # [
    #   {
    #     title: 'Spaghetti',
    #     description: 'It is delicious!'
    #   },
    #   {
    #     title: 'Lasagna',
    #     description: 'Yummy'
    #   }
    # ]
    end

  private

  def default_values
    self.completed ||= false
    nil                           # required so that TX will not rollback!!!
  end

end
