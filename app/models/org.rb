class Org < ActiveRecord::Base
  validates :name, presence: true
end
