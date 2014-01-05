require 'spec_helper'

describe StatUpdater, "#update_stats" do
  context "when a weight was not entered for the day" do
    it "keeps the previously recorded weight" do
      user = create(:fitbit_user)
      create(:daily_weight_information, weight: 100.0, user: user)
      stub_challenge_start_date('2013-12-01')
      stub_current_weight(0)
      stub_original_weight(123)

      StatUpdater.new(user).update_stats
      most_recent_weight = user.reload.daily_weight_informations.last

      expect(most_recent_weight.weight).to eq 100.0
    end

    it 'records a daily weight for the user' do
      user = create(:fitbit_user)
      stub_challenge_start_date('2013-12-01')
      stub_current_weight(100)
      stub_original_weight(999999)
      StatUpdater.new(user).update_stats

      weight_information = user.reload.daily_weight_informations.last
      expect(weight_information.weight).to eq(100)
    end

    it 'records the original weight entry for the user' do
      user = create(:fitbit_user)
      stub_challenge_start_date('2013-12-01')
      stub_original_weight(100)
      stub_current_weight(99999999)
      StatUpdater.new(user).update_stats

      weight_information = user.original_weight_information
      expect(weight_information.weight).to eq(100)
    end
  end

  def stub_current_weight(weight)
    stub_fitbit_api_request_with(Date.today, weight)
  end

  def stub_challenge_start_date(date)
    ENV['CHALLENGE_START_DATE'] = date
  end

  def stub_original_weight(weight)
    stub_fitbit_api_request_with(ENV['CHALLENGE_START_DATE'], weight)
  end

  def stub_fitbit_api_request_with(date, weight)
    stub_request(:get, "http://api.fitbit.com/1/user/-/body/date/#{date}.json").
      to_return(status: 200, body: { body: { weight: weight } }.to_json)
  end
end
