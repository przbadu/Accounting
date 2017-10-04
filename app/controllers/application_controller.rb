class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found(error)
    render json: {
      global_errors: "Couldn't find resource with given id"
    },
    status: :not_found
  end
end
