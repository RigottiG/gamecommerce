# frozen_string_literal: true

module Storefront
  module V1
    class ApiController < ActionController
      include Authenticable
    end
  end
end
