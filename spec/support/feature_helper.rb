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
  
end