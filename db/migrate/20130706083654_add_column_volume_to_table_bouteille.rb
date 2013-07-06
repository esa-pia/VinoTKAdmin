class AddColumnVolumeToTableBouteille < ActiveRecord::Migration
  def self.up
    add_column :bouteilles, :volume_id, :integer
    add_index :bouteilles, :volume_id
  end

  def self.down
    remove_index :bouteilles, :volume_id
    remove_column :bouteilles, :volume_id
  end
end
