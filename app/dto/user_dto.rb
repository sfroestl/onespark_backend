##
# The UserDTO class
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 26.10.2012


class UserDTO < UserSimpleDTO
  # include ApiHelper

  attr_accessor :projects

  def initialize(username, email, projects, workmates)
    @username = username
    @email = email
    @projects = projects
    @workmates = workmates
  end

  # def initialize(user)
  #   @username = user.username
  #   @email = user.email
  #   @projects = projects_to_simple_dto(user.projects)
  #   @workmates = users_to_workmates_dto(user.friends)
  # end

end