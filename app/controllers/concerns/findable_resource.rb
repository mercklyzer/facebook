# For this to work, the controller name must match its model
# i.e. PostsController -> Post (model)
module FindableResource
  extend ActiveSupport::Concern

  included do
    before_action :find_resource_by_id, only: find_resource_by_id_scoped_methods
  end

  class_methods do
    # override this in the controller if you must
    def find_resource_by_id_scoped_methods
      [:update, :destroy]
    end
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
