class WeightLossInformation < ActiveRecord::Base
  belongs_to :user

  def update_calculations!
    self.percentage_lost = calculate_percent_lost
    save
  end

  private

  def calculate_percent_lost
    if most_recent_weight < original_weight
      ((most_recent_weight/original_weight - 1) * 100).abs
    else
      0
    end
  end
end
