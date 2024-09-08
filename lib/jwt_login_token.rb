require 'jwt'

class JwtLoginToken
  SECRET_KEY = 'this_is_the_secret_key' # TODO: find a better way of storing this
  ALGORITHM = 'HS256'

  def self.encode(user_id)
    payload_object = payload(user_id)
    JWT.encode(payload_object, SECRET_KEY, ALGORITHM)
  end

  def self.decode(token)
    begin
      decoded_data = JWT.decode(token, SECRET_KEY, true, algorithm: ALGORITHM)
    rescue JWT::ExpiredSignature
      false
    end
  end

  private

  def self.payload(user_id)
    {
      user_id: user_id,
      exp: exp
    }
  end

  def self.exp
    2.hours.from_now.to_i
  end
end
