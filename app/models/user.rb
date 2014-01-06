class User < ActiveRecord::Base
  include Clearance::User
  has_one :fitbit_information
  has_one :weight_loss_information
  delegate :has_fitbit_authorization?, to: :fitbit_information, allow_nil: true
  delegate :percentage_lost, to: :weight_loss_information, allow_nil: true

  def self.with_fitbit_authorization
    self.all.select(&:has_fitbit_authorization?)
  end

  def name=(name)
     write_attribute(:name, name)
  end

  def name
    if read_attribute(:name).blank?
      email
    else
      read_attribute(:name)
    end
  end
end
