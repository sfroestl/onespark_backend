class CreateToolsRepositories < ActiveRecord::Migration
  def up
    create_table :tools_repositories do |t|
      t.string :url
      t.string :repo_type
      t.string :title
      t.integer :project_id

      t.timestamps
    end
  end

  def down
    drop_table :tools_repositories
  end
end
