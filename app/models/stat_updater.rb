class StatUpdater
  def self.run
    User.with_fitbit_authorization.each do |user|
      StatUpdater.new(user).update_stats
    end
  end

  def initialize(user)
    @user = user
    @fitbit_information = user.fitbit_information
    @user_secret = @fitbit_information.oauth_secret
    @user_token = @fitbit_information.oauth_token
  end

  def update_stats
    update_original_weight
    create_daily_weight
  end

  private
  attr_reader :user_token, :user_secret, :user, :weight_loss_information

  def create_daily_weight
    if Date.today.day != user.daily_weight_informations.last.created_at.day
      user.daily_weight_informations.create(weight: new_weight).calculate_difference!
    else
      if new_weight != user.current_weight
        user.daily_weight_informations.update(weight: new_weight).calculate_difference!
      end
    end
  end

  def new_weight
    if todays_weight > 0
      todays_weight
    else
      user.current_weight
    end
  end

  def update_original_weight
    if user.original_weight != original_weight
      user.original_weight_information.update(weight: original_weight)
    end
  end

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
