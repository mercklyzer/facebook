module FindableResource
  extend ActiveSupport::Concern

  included do
    before_action :find_resource_by_id, only: [:update, :destroy]
  end

  private

  def find_resource_by_id
    model = controller_name.classify.constantize
    find_resource(model)
  end

  def find_resource(model)
    begin
      resource = model.find(params[:id])
      instance_variable_set("@#{model.name.downcase}", resource)
    rescue => exception
      render json: { data: [], errors: [exception.message] }, status: 400
    end
  end
end
