module BelongsToPost
  extend ActiveSupport::Concern

  included do
    attr_reader :post

    before_action :set_post, :verify_post_exists
  end

  private

  def set_post
    @post = Post.find_by(id: params[:post_id])
  end

  def verify_post_exists
    return payload(errors: ["Post does not exist"], status: 400) unless post.present?
  end
end
