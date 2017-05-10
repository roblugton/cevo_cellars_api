module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches 'StandardErrors'
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end

  included do
    # define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_twenty_two
    rescue_from ActiveRecord::RecordNotFound do |ex|
      json_response({ message: ex.message }, :not_found)
    end
  end

  private

  # JSON response with message, status code 422 - unprocessable entity
  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  # JSON repsonse with message, status code 401 - Unauthorised
  def unauthorized_request(e)
    json_response({ message: e.message }, :unathorized)
  end
end
