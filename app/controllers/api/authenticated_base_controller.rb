module Api
  class AuthenticatedBaseController < ApplicationController
    include ApiKeyAuthenticable
  end
end
