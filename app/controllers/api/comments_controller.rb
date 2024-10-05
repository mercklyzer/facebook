module Api
  class CommentsController < AuthenticatedBaseController
    include Paginatable
    include BelongsToPost

    def index
      comments, comments_meta = paginate(post.comments)
      payload(data: comments, meta: comments_meta, status: 200)
    end
  end
end
