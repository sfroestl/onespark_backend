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