# frozen_string_literal: true

class SystemRequirement < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :operational_system, presence: true
  validates :memory, presence: true
  validates :processor, presence: true
  validates :video_board, presence: true
  validates :storage, presence: true
end
