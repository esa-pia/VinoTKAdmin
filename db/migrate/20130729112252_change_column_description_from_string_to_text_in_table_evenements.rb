class ChangeColumnDescriptionFromStringToTextInTableEvenements < ActiveRecord::Migration
def up
    change_column :evenements, :description, :text
end
def down
    change_column :evenements, :description, :string
end
end
