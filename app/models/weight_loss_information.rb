class WeightLossInformation < ActiveRecord::Base
  belongs_to :user

  def update_calculations!
    calculate_percent_lost
    save
  end

  private

  def calculate_percent_lost
    self.percentage_lost = ((most_recent_weight/original_weight - 1) *100).abs
  end
end
