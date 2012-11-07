##
# The ProjectDTO class
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 26.10.2012


class ProjectDTO < ProjectSimpleDTO

  attr_accessor :coworkers, :updated_at, :owner

  def initialize(project_data)
    Rails.logger.info"#{project_data[:coworkers]}"
    @id = project_data[:id]
    @title = project_data[:title]
    @desc = project_data[:desc]
    @due_date = project_data[:due_date]
    @coworkers = []
    project_data.coworkers.each do |user| @coworkers << { username: user.username } end
    @updated_at = project_data[:updated_at]
    @owner = User.find(project_data[:user_id]).username
  end


end