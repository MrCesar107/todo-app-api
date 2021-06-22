class CreateLabelTask < ActiveRecord::Migration[6.1]
  def change
    create_table :label_tasks do |t|
      t.references :label, index: true, null: false, foreign_key: true
      t.references :task, index: true, null: false, foreign_key: true

      t.timestamps
    end
  end
end
