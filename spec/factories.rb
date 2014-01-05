FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    factory :fitbit_user, traits: [:with_fitbit_information,
                                   :with_original_weight_loss_information]


    trait :with_fitbit_information do
      after(:create) do |user|
        user.fitbit_information = create(:fitbit_information)
      end
    end

    trait :with_original_weight_loss_information do
      after(:create) do |user|
        user.original_weight_information = create(:original_weight_information,
                                                  weight: 100)
      end
    end
  end

  factory :fitbit_information do
    oauth_token 'token'
    oauth_secret 'secret'
  end

  factory :original_weight_information do

  end
end
