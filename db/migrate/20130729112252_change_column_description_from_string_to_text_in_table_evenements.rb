class ChangeColumnDescriptionFromStringToTextInTableEvenements < ActiveRecord::Migration
  def up
	remove_column :evenements, :description
    add_column :evenements, :description, :text
  end
  def down
    remove_column :evenements, :description
    add_column :evenements, :description, :string
  end
end
