class ApplicationController < ActionController::Base
  def payload(data: [], errors: [], status: 200)
    render json: { data: data, errors: errors }, status: status
  end
end
