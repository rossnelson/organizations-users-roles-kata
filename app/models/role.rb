class Role < ActiveRecord::Base
  validates :name, presence: true
  validate :name_is_a_valid_option, :unique_within_a_grouping

  def self.name_options
    ['Admin', 'User', 'Denied']
  end

  def self.siblings(user_id, org_id)
    where(user_id: user_id, org_id: org_id)
  end

  private 

  def name_is_a_valid_option
    unless self.class.name_options.include?(name)
      errors.add :name, 'is not one of the allowed options' 
    end
  end

  def unique_within_a_grouping
    if self.class.siblings(user_id, org_id)
      .pluck(:name)
      .include?(self.name)

        errors.add :base, 
          'There is an existing role for this user and organization'
    end
  end

end
