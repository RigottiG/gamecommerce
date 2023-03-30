# frozen_string_literal: true

module Authenticate
  extend ActiveSupport::Concern

  included do
    include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :authenticate_user!
  end
end
