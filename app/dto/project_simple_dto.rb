class ProjectSimpleDTO < BaseDTO

  attr_accessor :id, :title, :desc, :due_date, :coworkers

  def initialize(project_data)
    @id = project_data[:id]
    @title = project_data[:title]
    @desc = project_data[:desc]
    @due_date = project_data[:due_date]
  end

end