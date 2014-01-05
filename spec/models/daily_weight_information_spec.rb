require 'spec_helper'

describe DailyWeightInformation do
  describe '.update_calculations' do
    it 'will calculate the percent lost between two number' do
      user = create(:fitbit_user)
      daily_weight_information = user.daily_weight_informations.create(weight: 90.0)
      user.original_weight_information.update(weight: 100.0)

      daily_weight_information.calculate_difference!

      expect(daily_weight_information.percentage_lost).to eq(10)
    end

    context 'when there is a weight gain' do
      it 'returns 0 as the percentage lost' do
        user = create(:fitbit_user)
        daily_weight_information = user.daily_weight_informations.create(weight: 110)
        user.original_weight_information.update(weight: 100)

        daily_weight_information.calculate_difference!

        expect(daily_weight_information.reload.percentage_lost).to be_zero
      end
    end
  end
end
