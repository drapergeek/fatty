require 'spec_helper'

describe StatUpdater, "#update_stats" do
  context "when a weight was not entered for the day" do
    it "keeps the previously recorded weight" do
      user = create(:user, :with_fitbit_information)
      create(:weight_loss_information, most_recent_weight: 100.0, user: user)
      stub_challenge_start_date('2013-12-01')
      stub_fitbit_api_request_with(Date.today, 0)
      stub_fitbit_api_request_with(ENV['CHALLENGE_START_DATE'], 123)

      StatUpdater.new(user).update_stats
      most_recent_weight = user.reload.weight_loss_information.most_recent_weight

      expect(most_recent_weight).to eq 100.0
    end
  end

  def stub_challenge_start_date(date)
    ENV['CHALLENGE_START_DATE'] = date
  end

  def stub_fitbit_api_request_with(date, weight)
    stub_request(:get, "http://api.fitbit.com/1/user/-/body/date/#{date}.json").
      to_return(status: 200, body: { body: { weight: weight } }.to_json)
  end
end
