##
# The ApiHelper class
#
# provides methods for converting Models to DTOs
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Edit:: 29.10.2012

module ApiHelper

  # Converts Array of Projects to Array of ProjectSimpleDTOs
  def projects_to_simple_dto(projects)
    project_dto_list = []

    projects.each do |project|
      project_dto = ProjectSimpleDTO.new(project)
      project_dto_list << project_dto
    end

    return project_dto_list
  end

  # Converts Array of Users to Array of WorkmateDTOs
  def users_to_workmates_dto(users)
    user_dto_list = []

    users.each do |project|
      workmate_dto = WorkmateDTO.new(project)
      user_dto_list << workmate_dto
    end

    return user_dto_list
  end

end