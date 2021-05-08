class Api::V1::CompaniesController < Api::V1::BaseController
  def index
    @companies = Company.all
  end
end