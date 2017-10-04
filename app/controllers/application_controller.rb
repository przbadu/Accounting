class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :strong_params_missing

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
