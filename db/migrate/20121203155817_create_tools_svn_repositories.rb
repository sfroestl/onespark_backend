class CreateToolsSvnRepositories < ActiveRecord::Migration
  def up
		create_table :tools_svn_repositories do |t|
			t.string :title
			t.string :url
			t.integer :project_id
			t.timestamp
		end
  end

  def down
		drop_table :tools_svn_repositories
  end
end
