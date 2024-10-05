module Api
  class CommentsController < AuthenticatedBaseController
    include Paginatable
    include BelongsToPost

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

    private

    def comment_params
      params.require(:comment).permit(:content)
    end
  end
end
