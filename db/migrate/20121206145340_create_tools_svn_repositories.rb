class CreateToolsSvnRepositories < ActiveRecord::Migration
  def up
		create_table :tools_svn_repositories do |t|
			t.string :title
			t.string :url
			t.string :svn_username
			t.string :svn_password
			t.integer :project_id

      t.timestamps
		end
		add_index :tools_svn_repositories, :project_id
  end

  def down
		drop_table :tools_svn_repositories
  end
end
