class Treatment < ApplicationRecord
  validates_presence_of :description, :necessity
end
