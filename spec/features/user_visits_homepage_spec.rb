require 'spec_helper'

feature "User views homepage" do
  scenario "sees current stats for everyone" do
    user = create(:user, :with_fitbit_information)
    another_user = create(:user, :with_fitbit_information)
    create(:weight_loss_information, percentage_lost: 2, user: user)
    create(:weight_loss_information, percentage_lost: 1, user: another_user)

    visit root_path(as: user)

    expect_user_stat_to_appear(user)
    expect_user_stat_to_appear(another_user)
  end

  def expect_user_stat_to_appear(user)
    expect(page).to have_content "#{user.email} has lost #{user.percentage_lost}%."
  end
end
