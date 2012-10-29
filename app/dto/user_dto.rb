class UserDTO < UserSimpleDTO

  attr_accessor :projects

  def initialize(username, email, projects, workmates)
    @username = username
    @email = email
    @projects = projects
    @workmates = workmates
  end

end