##
# The ProfileDTO class
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 11.11.2012


class ProfileDTO < BaseDTO

  attr_accessor :forename, :surname, :city, :about, :avatar_url

  def initialize(profile)
    @forename = profile.forename
    @surname = profile.surname
    @city = profile.city
    @about = profile.about
    @avatar_url = profile.avatar_url
  end
end
