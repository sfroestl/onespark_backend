##
# The ProjectSimpleDTO class
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 26.10.2012

class ProjectSimpleDTO < BaseDTO

  attr_accessor :id, :title, :desc, :due_date, :coworkers

  def initialize(project_data)
    @id = project_data[:id]
    @title = project_data[:title]
    @desc = project_data[:desc]
    @due_date = project_data[:due_date]
  end

end