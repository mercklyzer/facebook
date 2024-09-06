module Paginatable
  extend ActiveSupport::Concern

  DEFAULT_PAGE_SIZE = 20

  included do
    before_action :set_default_pagination
    rescue_from ArgumentError, with: :invalid_pagination_params
  end

  private

  def set_default_pagination
    @page_number = params[:page][:number]&.to_i || 1
    @page_size = params[:page][:size]&.to_i || DEFAULT_PAGE_SIZE

    raise ArgumentError, 'Page number must be an integer greater than zero' if @page_number < 1
    raise ArgumentError, 'Page size must be an integer greater than zero' if @page_size < 1
  end

  def paginate(scope)
    data = scope.paginate(per_page: @page_size, page: @page_number)
    meta = meta(data)
    [data, meta]
  end

  def meta(paginated_scope)
    {
      total_count: paginated_scope.total_entries,
      total_pages: paginated_scope.total_pages,
      current_page: paginated_scope.current_page,
      per_page: paginated_scope.per_page,
      previous_page: paginated_scope.previous_page,
      next_page: paginated_scope.next_page
    }
  end

  def invalid_pagination_params(exception)
    render json: { data: [], errors: [exception.message] }, status: 400
  end
end
