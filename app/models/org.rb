class Org < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  def self_and_descendants
    descendants ? descendants.unshift(self) : [self]
  end

  def descendants
    nil
  end
end
