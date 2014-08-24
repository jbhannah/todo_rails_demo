class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.references :user, index: true
      t.string :name
      t.boolean :completed, default: false
      t.datetime :completed_at

      t.timestamps
    end
  end
end
