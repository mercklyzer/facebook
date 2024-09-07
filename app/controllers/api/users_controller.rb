module Api
  class UsersController < ApplicationController
    def signup
      user = User.new(user_params)
      saved_ok = user.save

      if saved_ok
        user = user_without_password(user)
        payload(data: user, status: 200)
      else
        payload(errors: user.errors.map(&:full_message), status: 400)
      end
    end

    private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :last_name, :email)
    end

    def user_without_password(user)
      user.as_json(except: [:password_digest])
    end
  end
end
