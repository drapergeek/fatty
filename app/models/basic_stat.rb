class BasicStat
  include ActiveModel::Model
  include ActiveModel::Serialization
  attr_reader :email, :percentage_lost

  def self.all
    User.with_fitbit_authorization.map do |user|
      BasicStat.new(user)
    end
  end

  def initialize(user)
    @email = user.email
    @percentage_lost = user.percentage_lost
  end
end
