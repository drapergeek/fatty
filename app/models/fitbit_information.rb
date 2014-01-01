class FitbitInformation < ActiveRecord::Base
  belongs_to :user

  def has_fitbit_authorization?
    oauth_token.present? && oauth_secret.present?
  end
end
