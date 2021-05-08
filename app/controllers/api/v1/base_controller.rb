class Api::V1::BaseController < ActionController::API
  include Pundit

  after_action :authenticate_user!, only: %i[index show]
  after_action :authenticate_user!, only: %i[new create edit update review]

  rescue_from Pundit::NotAuthorizedError,   with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  private

  def user_not_authorized(exception)
    render json: {
      error: "Unauthorized #{exception.policy.class.to_s.underscore.camelize}.#{exception.query}"
    }, status: :unauthorized
  end

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
