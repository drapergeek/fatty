require 'spec_helper'

describe BasicStat do
  describe '.all' do
    it 'returns an array of BasicStats, one for each user' do
      user = create(:user, :with_fitbit_information)

      stats = BasicStat.all
      first_stat = stats.first

      expect(first_stat.email).to eq(user.email)
    end

     it 'does not include users who are not authenticated through fitbit' do
      create(:user)
      user = create(:user, :with_fitbit_information)

      stats = BasicStat.all
      first_stat = stats.first

      expect(first_stat.email).to eq(user.email)
      expect(stats.length).to eq(1)
     end
  end

  describe '.ordered_by_percentage' do
    it 'returns the basic stats ordered from highest percentage to least' do
      user_with_percentage_lost(1.0)
      user_with_percentage_lost(2.0)

      stats = BasicStat.ordered_by_percentage

      expect(stats.map(&:percentage_lost)).to eq [2.0, 1.0]
    end
  end

  describe '#percentage_lost' do
    it 'returns the percentage lost from the users weight loss information' do
      user = create(:user, :with_weight_loss_information)

      stat = BasicStat.new(user)

      expect(stat.percentage_lost).to eq(user.percentage_lost)
    end
  end

  def user_with_percentage_lost(percent)
    user = create(:user, :with_fitbit_information)
    create(:weight_loss_information, percentage_lost: percent, user: user)
    user
  end
end
