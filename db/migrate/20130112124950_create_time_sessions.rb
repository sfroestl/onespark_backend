class CreateTimeSessions < ActiveRecord::Migration
  def up
    create_table :time_sessions do |t|
      t.datetime :start
      t.datetime :end
      t.integer :task_id
      t.integer :user_id
      t.timestamps
    end
  end
  def down
    drop_table :time_sessions
  end
end
