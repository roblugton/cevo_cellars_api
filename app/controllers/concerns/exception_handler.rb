module ExceptionHandler
    extend ActiveSupport::Concern

    included do
        rescue_from ActiveRecord::RecordNotFound do |ex|
            json_response({message: ex.message}, :not_found)
        end

        rescue_from ActiveRecord::RecordInvalid do |ex|
            json_response({ message: ex.message}, :not_found)
        end

    end
end
