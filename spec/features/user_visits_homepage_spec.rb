require 'spec_helper'

feature "User views homepage" do
  scenario "sees current stats for everyone" do
    user = create(:fitbit_user)
    another_user = create(:user, :with_fitbit_information)
    user.daily_weight_informations.create(percentage_lost: 2)
    another_user.daily_weight_informations.create(percentage_lost: 1)

    visit root_path(as: user)

    expect_user_stat_to_appear(user)
    expect_user_stat_to_appear(another_user)
  end

  def expect_user_stat_to_appear(user)
    expect(page).to have_content "#{user.email} has lost #{user.percentage_lost}%."
  end
end
