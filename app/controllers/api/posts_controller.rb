module Api
  class PostsController < ApplicationController
    include Paginatable

    def index
      posts, posts_meta = paginate(Post.all)
      payload(data: posts, meta: posts_meta, status: 200)
    end
  end
end
