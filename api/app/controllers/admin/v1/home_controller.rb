# frozen_string_literal: true

module Admin
  module V1
    class HomeController < ApiController
      def index
        render json: { message: 'Welcome to the Game Commerce API' }
      end
    end
  end
end
