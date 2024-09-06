module Api
  class PostsController < ApplicationController
    include Paginatable

    def index
      posts = paginate(Post.all)
      payload(data: posts, status: 200)
    end
  end
end
