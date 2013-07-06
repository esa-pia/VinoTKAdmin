class DeleteColumnFormatToBouteilleTable < ActiveRecord::Migration
  def up
  	remove_index :bouteilles, :format_id
  	remove_column :bouteilles, :format_id
  	drop_table :formats
  end

  
  def down
  	add_column :bouteilles, :format, :reference
  	add_index :bouteilles, :format_id
  	create_table :formats do |t|
      t.string :valeur

      t.timestamps
    end
  end
end
