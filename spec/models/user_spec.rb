require 'spec_helper'

describe User do

  describe '#current_weight' do
    it "will delegate to the most recent daily weight information's weight" do
      user = create(:user)
      user.daily_weight_informations.create(weight: 8.0)

      expect(user.current_weight).to eq(8.0)
    end
  end
end
