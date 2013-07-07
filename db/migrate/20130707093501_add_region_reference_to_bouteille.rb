class AddRegionReferenceToBouteille < ActiveRecord::Migration
  def self.up
    add_column :bouteilles, :region_id, :integer
    add_index :bouteilles, :region_id
  end

  def self.down
    remove_index :bouteilles, :region_id
    remove_column :bouteilles, :region_id
  end
end