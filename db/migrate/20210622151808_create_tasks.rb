class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.references :chart, index: true, foreign_key: true

      t.timestamps
    end
  end
end
