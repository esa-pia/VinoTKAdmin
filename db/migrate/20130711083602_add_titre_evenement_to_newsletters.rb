class AddTitreEvenementToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :titre_evenement, :string
  end
end
