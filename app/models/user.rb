class User < ActiveRecord::Base
  include Clearance::User
  has_one :fitbit_information
  delegate :has_fitbit_authorization?, to: :fitbit_information, allow_nil: true

end
