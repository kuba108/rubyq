class Route < ApplicationRecord

  belongs_to :routable, polymorphic: true, optional: true

  ROUTE_TYPES = %w( standard redirect ).freeze

end
