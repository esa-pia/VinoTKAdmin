class CreateCuvees < ActiveRecord::Migration
  def change
    create_table :cuvees do |t|
      t.string :libelle

      t.timestamps
    end
  end
end
