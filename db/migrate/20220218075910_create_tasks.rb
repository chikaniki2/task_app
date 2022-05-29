class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.date :date_start
      t.date :date_end
      t.boolean :is_allday
      t.string :memo

      t.timestamps
    end
  end
end
