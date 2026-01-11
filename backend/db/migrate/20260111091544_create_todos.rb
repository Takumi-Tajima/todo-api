class CreateTodos < ActiveRecord::Migration[8.1]
  def change
    create_table :todos do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.boolean :completed, null: false, default: false
      t.integer :priority, null: false, default: 0
      t.date :due_date, null: false
      t.bigint :user_id

      t.timestamps
    end
  end
end
