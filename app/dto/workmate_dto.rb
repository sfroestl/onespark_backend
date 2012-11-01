##
# The WorkmateDTO class
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 26.10.2012


class WorkmateDTO < BaseDTO
  attr_accessor :username

  def initialize(user)
    @username = user.username
  end

end