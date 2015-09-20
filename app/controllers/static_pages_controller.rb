class StaticPagesController < ApplicationController
  before_action :logged_in_user, except: [:home, :about]
  def home
    @user = current_user
  end

  def about
    @user = current_user
  end
end
