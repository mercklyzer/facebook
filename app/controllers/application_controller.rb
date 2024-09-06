class ApplicationController < ActionController::Base
  def payload(data: [], meta: [], errors: [], status: 200)
    render json: { data: data, meta: meta, errors: errors }, status: status
  end
end
