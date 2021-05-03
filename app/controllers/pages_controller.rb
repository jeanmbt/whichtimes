class PagesController < ApplicationController
  def dashboard
    @companies = Companies.where()
  end
end
