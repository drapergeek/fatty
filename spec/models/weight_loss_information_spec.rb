require 'spec_helper'

describe WeightLossInformation do
  describe '.update_calculations' do
    it 'will calculate the percent lost between two number' do
      weight_loss_information = WeightLossInformation.new(
        original_weight: 100,
        most_recent_weight: 90)
      weight_loss_information.update_calculations!
      percentage_lost = WeightLossInformation.first.percentage_lost
      expect(percentage_lost).to eq(10)
    end

    context 'when there is a weight gain' do
      it 'returns 0 as the percentage lost' do
        weight_lost_information = WeightLossInformation.new(
          original_weight: 100,
          most_recent_weight: 110,
        )

        weight_lost_information.update_calculations!
        percentage_lost = WeightLossInformation.first.percentage_lost

        expect(percentage_lost).to be_zero
      end
    end
  end
end
