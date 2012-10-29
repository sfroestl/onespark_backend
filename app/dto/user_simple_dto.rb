class UserSimpleDTO < BaseDTO

  attr_accessor :username, :email, :workmates

  def initialize(username, email, workmates)
    @username = username
    @email = email
    @workmates = workmates
  end

end