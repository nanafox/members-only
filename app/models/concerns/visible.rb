# Handles the visibility of objects
module Visible
  extend ActiveSupport::Concern

  VALID_STATUSES = %w[public private archive draft]

  included do
    validates :status, inclusion: { in: VALID_STATUSES }
  end
end
