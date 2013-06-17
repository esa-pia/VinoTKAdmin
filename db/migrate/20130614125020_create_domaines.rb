class CreateDomaines < ActiveRecord::Migration
  def change
    create_table :domaines do |t|
      t.string :libelle

      t.timestamps
    end
  end
end
