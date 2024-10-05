module Api
  class ReactionsController < AuthenticatedBaseController
    include Paginatable
    include BelongsToPost

    attr_reader :reaction

    before_action :set_reaction, :verify_reaction_exists, :verify_user_owns_reaction ,only: [:update, :destroy]

    def index
      reactions, reactions_meta = paginate(post.reactions)
      payload(data: reactions, meta: reactions_meta, status: 200)
    end

    def create
      reaction = Reaction.new(user: user, owner: post, reaction: reaction_params[:type])
      saved_ok = reaction.save

      if saved_ok
        payload(data: reaction, status: 200)
      else
        payload(errors: reaction.errors.map(&:full_message), status: 400)
      end
    end

    def update
      if reaction.update(reaction: reaction_params[:type])
        payload(data: reaction, status: 200)
      else
        payload(errors: reaction.errors.map(&:full_message), status: 400)
      end
    end

    def destroy
      delete_ok = reaction.destroy

      if delete_ok
        payload(data: reaction, status: 200)
      else
        payload(errors: reaction.errors.map(&:full_message), status: 400)
      end
    end

    private
    def reaction_params
      params.require(:reaction).permit(:type)
    end

    def set_reaction
      @reaction = Reaction.find_by(id: params[:id])
    end

    def verify_reaction_exists
      return payload(errors: ["Reaction does not exist"], status: 400) unless reaction.present?
    end

    def verify_user_owns_reaction
      return payload(errors: ["User does not own the reaction"], status: 400) if user.id != reaction.user_id
    end
  end
end
