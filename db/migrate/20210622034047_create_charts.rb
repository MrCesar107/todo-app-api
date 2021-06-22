class CreateCharts < ActiveRecord::Migration[6.1]
  def change
    create_table :charts do |t|
      t.string :name
      t.text :description
      t.references :workspace, index: true, foreign_key: true

      t.timestamps
    end
  end
end
