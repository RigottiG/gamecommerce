# frozen_string_literal: true

module NameSearchable
  extend ActiveSupport::Concern

  included do
    scope :search_by_name, lambda { |name|
      where('name ILIKE ?', "%#{name}%")
    }
  end
end
