module Api
  class CommentsController < AuthenticatedBaseController
    include Paginatable
    include BelongsToPost

    attr_reader :comment

    before_action :set_comment, :verify_comment_exists, :verify_user_owns_comment ,only: [:update]

    def index
      comments, comments_meta = paginate(post.comments)
      payload(data: comments, meta: comments_meta, status: 200)
    end

    def create
      comment = Comment.new({user: user, post: post}.merge(comment_params))
      saved_ok = comment.save

      if saved_ok
        payload(data: comment, status: 200)
      else
        payload(errors: comment.errors.map(&:full_message), status: 400)
      end
    end

    def update
      if comment.update(comment_params)
        payload(data: comment, status: 200)
      else
        payload(errors: comment.errors.map(&:full_message), status: 400)
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_comment
      @comment = Comment.find_by(id: params[:id])
    end

    def verify_comment_exists
      return payload(errors: ["Comment does not exist"], status: 400) unless comment.present?
    end

    def verify_user_owns_comment
      return payload(errors: ["User does not own the comment"], status: 400) if user.id != comment.user_id
    end
  end
end
