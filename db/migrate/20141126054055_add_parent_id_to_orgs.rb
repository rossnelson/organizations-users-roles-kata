class AddParentIdToOrgs < ActiveRecord::Migration
  def change
    add_column :orgs, :parent_id, :integer
    add_column :orgs, :type, :string
  end
end
