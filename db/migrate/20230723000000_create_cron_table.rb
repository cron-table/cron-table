class CreateCronTable < ActiveRecord::Migration[7.0]
  def change
    create_table :cron_table do |t|
      t.string :key, null: false, index: { unique: true }

      t.datetime :next_run_at, index: true
      t.datetime :last_run_at
      t.datetime :created_at, null: false
    end
  end
end
