class Gym < ApplicationRecord
  validates :subdomain, uniqueness: true, allow_blank: true,
            format: { with: /\A[a-z0-9]([a-z0-9-]*[a-z0-9])?\z/,
                       message: "only allows lowercase letters, numbers, and hyphens" }
end
