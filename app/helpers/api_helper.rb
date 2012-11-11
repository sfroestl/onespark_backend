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
  def users_to_contacts(users)
    contacts_list = []

    users.each do |user|
      contacts_list << { username: user.username }
    end
    return contacts_list
  end

  def user_to_dto(user)
    userDTO = UserDTO.new(user.username, user.email,
      projects_to_simple_dto(user.projects),
      users_to_contacts(user.friends),
      profile_to_profile_dto(user.profile))
    return userDTO
  end

  def profile_to_profile_dto(profile)
    ProfileDTO.new(profile)
  end



end