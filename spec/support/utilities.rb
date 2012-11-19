def full_title(page_title)
  base_title = "One Spark"

  if page_title.empty?
    return base_title
  else
    return "#{base_title} | #{page_title}"
  end
end

def sign_in(user)
     visit signin_path
     fill_in "email_or_username",    with: user.email
     fill_in "password", with: user.password
     click_button "Sign in"
     # Sign in when not using Capybara as well.
     cookies[:remember_token] = user.remember_token
end

# returns the basic auth header
def basic_auth(username)
  credentials = ActionController::HttpAuthentication::Basic.encode_credentials username, 'foobar'
  { 'HTTP_AUTHORIZATION' =>  credentials }
end