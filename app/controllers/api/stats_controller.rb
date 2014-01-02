class Api::StatsController < ApiController
  respond_to :json

  def index
    StatUpdater.run
    respond_with BasicStat.ordered_by_percentage, each_serializer: BasicStatSerializer
  end
end
