# controllers that will use this module should have a payload method
module ApiKeyAuthenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_api_key, :set_user_from_api_key
    attr_reader :api_key, :user
  end

  private

  def authenticate_api_key
    @api_key = request.headers['FACEBOOK-API-KEY']

    return payload(errors: ["API key is missing"], status: :unauthorized) unless @api_key

    payload(errors: ["Invalid API key"], status: :unauthorized) unless valid_api_key?
  end

  def set_user_from_api_key
    @user = User.find_by(id: decoded_token_user_id)
  end

  def valid_api_key?
    user_id = decoded_token_user_id
    user_id && User.exists?(id: user_id)
  end

  def decoded_token_user_id
    decoded_token = JwtLoginToken.decode(@api_key)
    decoded_token.present? ? decoded_token[0]["user_id"] : nil
  end

end
