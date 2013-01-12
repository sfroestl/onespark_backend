class ExtendTasks < ActiveRecord::Migration
  def up
    add_column :tasks, :completed, :boolean, default: false
    add_column :tasks, :completed_at, :datetime
    add_column :tasks, :completed_by, :integer
    add_column :tasks, :estimated_hours, :float
    add_column :tasks, :worked_hours, :float
  end

  def down
    remove_column :tasks, :completed, :boolean
    remove_column :tasks, :completed_at, :datetime
    remove_column :tasks, :completed_by, :integer
    remove_column :tasks, :estimated_hours, :float
    remove_column :tasks, :worked_hours, :float
  end
end
