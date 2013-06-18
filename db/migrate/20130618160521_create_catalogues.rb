class CreateCatalogues < ActiveRecord::Migration
  def change
    create_table :catalogues do |t|
      t.string :titre

      t.timestamps
    end
  end
end
