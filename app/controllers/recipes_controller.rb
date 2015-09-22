class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  require "httparty"
  # GET /recipes
  # GET /recipes.json
  def search
    @search_text = search_params[:q] || ''
    @search_result = Recipe.search(@search_text) unless @search_text.empty?
  end

  def index
    @recipes = []
    user_recipes = current_user.recipes
    user_recipes.each do |user_recipe|
      base_url = "http://api.yummly.com/v1/api/recipe"
      app_id = "a60a3813"
      app_key = "03a140c9f2bc94ab668e30a025477217"
      recipe_id = user_recipe.api_id

      url = "#{base_url}/#{recipe_id}?_app_id=#{app_id}&_app_key=#{app_key}"

      @recipes << (HTTParty.get url)
    end
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit

  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        current_user.recipes << @recipe
        format.html { redirect_to @recipe, notice: 'Recipe was successfully added.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:api_id)
    end

    def search_params
      params.permit(:q)
    end
end
