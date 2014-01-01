FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'

    trait :with_fitbit_information do
      after(:create) do |user|
        user.fitbit_information = create(:fitbit_information)
      end
    end

    trait :with_weight_loss_information do
      after(:create) do |user|
        user.weight_loss_information = create(:weight_loss_information, percentage_lost: 1.2)
      end
    end
  end

  factory :fitbit_information do
    oauth_token 'token'
    oauth_secret 'secret'
  end

  factory :weight_loss_information do

  end
end
