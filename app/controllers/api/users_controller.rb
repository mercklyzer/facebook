module Api
  class UsersController < ApplicationController
    def signup
      user = User.new(signup_params)
      signup_ok = user.save

      if signup_ok
        user = user_without_password(user)
        jwt = ::JwtLoginToken.encode(user[:id])
        payload(data: {user: user, token: jwt}, status: 200)
      else
        payload(errors: user.errors.map(&:full_message), status: 400)
      end
    end

    def login
      username_or_email = login_params[:username_or_email]
      password = login_params[:password]

      user = User.find_by(username: username_or_email) || User.find_by(email: username_or_email)

      if user.blank?
        payload(errors: ["User does not exist."], status: 400)
      elsif user.authenticate(password).blank?
        payload(errors: ["Incorrect password."], status: 400)
      else
        user = user_without_password(user)
        jwt = ::JwtLoginToken.encode(user[:id])
        payload(data: {user: user, token: jwt}, status: 200)
      end
    end

    private

    def signup_params
      params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :last_name, :email)
    end

    def login_params
      params.require(:user).permit(:username_or_email, :password)
    end

    def user_without_password(user)
      user.as_json(except: [:password_digest]).deep_symbolize_keys
    end
  end
end
