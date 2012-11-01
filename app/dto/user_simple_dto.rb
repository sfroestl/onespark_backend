##
# The UserSimpleDTO class
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 26.10.2012


class UserSimpleDTO < BaseDTO

  attr_accessor :username, :email, :workmates

  def initialize(username, email, workmates)
    @username = username
    @email = email
    @workmates = workmates
  end

end