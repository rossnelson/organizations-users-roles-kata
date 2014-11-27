class AddParentIdToOrgs < ActiveRecord::Migration
  def change
    add_column :orgs, :parent_id, :integer
  end
end
