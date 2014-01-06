require 'spec_helper'

feature "User updates info" do
  scenario "in the editor" do
    user = create(:user, name: "")

    visit root_path(as: user)

    click_link "Edit Information"
    fill_in "Name", with: "New Name"
    click_button "Update"

    expect(page).to have_content "New Name"
  end
end
