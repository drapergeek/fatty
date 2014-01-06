class User < ActiveRecord::Base
  include Clearance::User
  has_one :fitbit_information
  has_one :original_weight_information

  has_many :daily_weight_informations

  delegate :has_fitbit_authorization?, to: :fitbit_information, allow_nil: true

  def current_weight
    daily_weight_informations.last.weight
  end

  def percentage_lost
    daily_weight_informations.last.percentage_lost
  end

  def original_weight
    original_weight_information.weight
  end

  def self.with_fitbit_authorization
    self.all.select(&:has_fitbit_authorization?)
  end
end
