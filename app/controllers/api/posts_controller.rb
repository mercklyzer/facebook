module Api
  class PostsController < ApplicationController
    include FindableResource
    include Paginatable

    def index
      posts, posts_meta = paginate(Post.all)
      payload(data: posts, meta: posts_meta, status: 200)
    end

    def create
      post = Post.new(post_params)
      saved_ok = post.save

      if saved_ok
        payload(data: post, status: 200)
      else
        payload(errors: post.errors.map(&:full_message), status: 400)
      end
    end

    def update
      update_ok = @post.update(post_params)

      if update_ok
        payload(data:@post, status: 200)
      else
        payload(errors:@post.errors.map(&:full_message), status: 400)
      end
    end

    def destroy
      delete_ok = @post.destroy

      if delete_ok
        payload(data:@post, status: 200)
      else
        payload(errors:@post.errors.map(&:full_message), status: 400)
      end
    end

    private

    def post_params
      params.require(:post).permit(:content)
    end
  end
end
