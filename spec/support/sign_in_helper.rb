module SignInHelper

  def sign_in_as(user)
    visit new_user_session_path
    fill_in 'Email', with: user[:email]
    fill_in 'user_password', with: user.password
    click_on 'Sign in'
  end

end
