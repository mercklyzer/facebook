module Api
  class PostsController < ApplicationController
    def index
      posts = Post.all
      return render json: {data: posts}, status: 200
    end
  end
end
