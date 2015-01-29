module FeatureHelper

  def sign_in(user)
    visit root_path

    within '.user-info' do
      click_link 'Sign In'
    end
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    within 'form' do
      click_button 'Log in'
    end
    expect( page ).to have_content("Signed in successfully.")
  end

  def authenticated_user(options={})
    user_options = {
      email: "email#{rand}@fake.com",
      password: 'password'
    }.merge(options)

    user = User.new(user_options)
    user.skip_confirmation!
    user.save
    user
  end
  
end