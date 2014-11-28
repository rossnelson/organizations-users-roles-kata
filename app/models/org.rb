class Org < ActiveRecord::Base
  validates :name, presence: true

  def self_and_descendants
    descendants ? descendants.unshift(self) : [self]
  end

  def descendants
    nil
  end
end
