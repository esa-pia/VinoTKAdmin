class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :libelle

      t.timestamps
    end
  end
end
