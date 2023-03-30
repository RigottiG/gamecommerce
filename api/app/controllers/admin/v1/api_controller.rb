# frozen_string_literal: true

module Admin
  module V1
    class ApiController < ApplicationController
      class ForbiddenAccess < StandardError; end
      include Authenticate

      def render_error(message: nil, fields: nil, status: :unprocessable_entity)
        errors = {}
        errors['fields'] = fields if fields.present?
        errors['message'] = message if message.present?

        render json: { errors: }, status:
      end
    end
  end
end
