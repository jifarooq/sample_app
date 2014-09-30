def full_title(page_title)
  base_title = "Ruby on Rails Tutorial Sample App"
  page_title.empty? ? base_title : "#{base_title} | #{page_title}"
end    

def sign_in(user, path_to_visit = signin_path)
  visit path_to_visit
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  
  #Sign in when not using Capybara as well
  cookies[:remember_token] = user.remember_token
end

#my own creation!
def fill_in_form(name, email, password)
	  fill_in "Name",             with: name
    fill_in "Email",            with: email
    fill_in "Password",         with: password
    fill_in "Confirm Password", with: password
end