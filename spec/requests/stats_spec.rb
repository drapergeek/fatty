require 'spec_helper'

describe 'api/stats' do
  describe '#index' do
    it 'returns a list of all users with fitbit information' do
      create(:user, :with_fitbit_information, email: 'spiderman@example.com')

      get '/api/stats', format: 'json'

      expect(json_body[0]["email"]).to eq('spiderman@example.com')
    end

    it 'returns the percentage lost for the user' do
      user = create(:user, :with_fitbit_information)
      create(:weight_loss_information,
             percentage_lost: 1.2,
             user: user)

      get '/api/stats', format: :json

      expect(json_body[0]["percentage_lost"]).to eq(1.2)
    end

    def json_body
      JSON.parse(response.body)['stats']
    end
  end
end
