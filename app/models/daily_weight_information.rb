class DailyWeightInformation < ActiveRecord::Base
  belongs_to :user

  def calculate_difference!
    self.percentage_lost = calculate_percent_lost
    save
  end

  private

  def calculate_percent_lost
    if weight < user.original_weight
      (((weight/user.original_weight - 1) * 100).abs).round(2)
    else
      0
    end
  end
end
