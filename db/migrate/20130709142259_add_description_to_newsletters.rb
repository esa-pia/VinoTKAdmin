class AddDescriptionToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :description, :text
  end
end
