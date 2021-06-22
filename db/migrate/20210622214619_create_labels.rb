class CreateLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :labels do |t|
      t.string :name, null: false
      t.string :color, default: '#b5b5b5', null: false

      t.timestamps
    end
  end
end
