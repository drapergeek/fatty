class StatUpdater
  def self.run
    User.with_fitbit_authorization.each do |user|
      StatUpdater.new(user).update_stats
    end
  end

  def initialize(user)
    @user = user
    @fitbit_information = user.fitbit_information
    @weight_loss_information = user.weight_loss_information
    @user_secret = @fitbit_information.oauth_secret
    @user_token = @fitbit_information.oauth_token
  end


  def update_stats
    if todays_weight > 0
      weight_loss_information.update!(
        most_recent_weight: todays_weight,
        weight_updated_on: Date.today
      )
    end

    if weight_loss_information.original_weight != original_weight
      weight_loss_information.update!(
        original_weight: original_weight
      )
    end
    weight_loss_information.update_calculations!
  end

  private
  attr_reader :user_token, :user_secret, :user, :weight_loss_information

  def todays_weight
    weight_for_date('today')
  end

  def original_weight
    weight_for_date(ENV['CHALLENGE_START_DATE'])
  end

  def weight_for_date(date)
    fitgem.body_measurements_on_date(date)["body"]["weight"]
  end

  def fitgem
    @fitgem ||= Fitgem::Client.new(
      consumer_key: ENV['FITBIT_CONSUMER_KEY'],
      consumer_secret: ENV['FITBIT_CONSUMER_SECRET'],
      token: user_token,
      secret: user_secret
    )
  end
end
