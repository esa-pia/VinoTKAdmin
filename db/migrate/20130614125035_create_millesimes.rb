class CreateMillesimes < ActiveRecord::Migration
  def change
    create_table :millesimes do |t|
      t.string :valeur

      t.timestamps
    end
  end
end
