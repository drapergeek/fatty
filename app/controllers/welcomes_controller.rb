class WelcomesController < ApplicationController
  def show
    @stats = BasicStat.ordered_by_percentage
  end
end
