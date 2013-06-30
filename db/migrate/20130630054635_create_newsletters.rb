class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :titre
      t.datetime :date_debut
      t.datetime :date_fin
      t.string :info

      t.timestamps
    end
  end
end
