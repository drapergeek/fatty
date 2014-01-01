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

  describe '#percentage_lost' do
    it 'returns the percentage lost from the users weight loss information' do
      user = create(:user, :with_weight_loss_information)

      stat = BasicStat.new(user)

      expect(stat.percentage_lost).to eq(user.percentage_lost)
    end
  end
end
