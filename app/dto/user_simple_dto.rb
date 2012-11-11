##
# The UserSimpleDTO class
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 26.10.2012


class UserSimpleDTO < BaseDTO

  attr_accessor :username, :email, :profile

  def initialize(username="", email="", profile=nil)
    @username = username
    @email = email
    @profile = ProfileDTO.new(profile)
  end

  # def initialize(params)
  #   @username = params[:username]
  #   @email = params[:email]
  #   @workmates = params[:workmates]
  # end


end