class Api::V1::BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :strong_params_missing

  def error_response(message, status=400)
    render json: { errors: message }, status: status
  end

  def global_error_response(message, status=400)
    render json: { global_errors: message }, status: status
  end

  private

  def record_not_found
    render json: {
      global_errors: "Couldn't find resource with given id"
    },
    status: :not_found
  end

  def strong_params_missing(error)
    render json: { global_errors: error.message }, status: :bad_request
  end
end
