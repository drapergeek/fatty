class Api::StatsController < ApiController
  respond_to :json

  def index
    StatUpdater.run
    respond_with BasicStat.all, each_serializer: BasicStatSerializer
  end
end
