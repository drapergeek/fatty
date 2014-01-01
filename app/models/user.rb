class User < ActiveRecord::Base
  include Clearance::User
  has_one :fitbit_information
  has_one :weight_loss_information
  delegate :has_fitbit_authorization?, to: :fitbit_information, allow_nil: true
  delegate :percentage_lost, to: :weight_loss_information, allow_nil: true

  def self.with_fitbit_authorization
    self.all.select(&:has_fitbit_authorization?)
  end
end
