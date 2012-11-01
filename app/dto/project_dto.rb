##
# The ProjectDTO class
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 26.10.2012


class ProjectDTO < ProjectSimpleDTO

  attr_accessor :coworkers

  def initialize(project_data)
    @id = project_data[:id]
    @title = project_data[:title]
    @desc = project_data[:desc]
    @due_date = project_data[:due_date]
    @coworkers = project_data[:coworkers]
  end

end