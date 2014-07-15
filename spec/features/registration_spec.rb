feature "User registering for a page" do
  scenario "when they use a valid username and password they can log in" do
    visit "/"

    click_on "Register"

    fill_in "Username", :with => "jetaggart"
    fill_in "Password", :with => "password"
    click_on "Register"

    fill_in "Username", :with => "jetaggart"
    fill_in "Password", :with => "password"

    click_on "Login"

    expect(page).to have_content("Welcome, jetaggart")
  end
end
