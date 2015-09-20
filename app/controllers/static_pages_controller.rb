class StaticPagesController < ApplicationController
  before_action :logged_in_user, except: [:home, :about]
  def home
  end

  def about
  end
end
