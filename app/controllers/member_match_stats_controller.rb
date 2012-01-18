class MemberMatchStatsController < ApplicationController
  def index
  end

  def new
    @match = Match.find(params[:match_id])
    @home_team = @match.home_team
    @away_team = @match.away_team
  end

  def edit
  end

  def show
  end

end
