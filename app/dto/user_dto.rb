##
# The UserDTO class
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 26.10.2012


class UserDTO < UserSimpleDTO
  # include ApiHelper

  attr_accessor :projects, :contacts

  def initialize(username="", email="", projects=[], contacts=[], profile=[])
    @username = username
    @email = email
    @projects = projects
    @contacts = contacts
    @profile = ProfileDTO.new(profile)
  end

  # def init_with_user(params)
  #   @username = params[:username]
  #   @email = params[:email]
  #   @projects = params[:projects]
  #   @workmates = params[:workmates]
  # end



  # def init_with_user(user)
  #   @username = user.username
  #   @email = user.email
  #   @projects = projects_to_simple_dto(user.projects)
  #   @workmates = users_to_workmates_dto(user.friends)
  # end

end