class AddApiIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :api_id, :string
  end
end
