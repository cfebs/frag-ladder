class MemberMatchRecordsController < ApplicationController
  def index
  end

  def new
    @match = Match.find(params[:match_id])
    3.times do @match.member_match_records.build end
    @home_team = @match.home_team
    @away_team = @match.away_team
  end

  def create
    @match = Match.find(params[:match_id])
  end

  def edit
  end

  def update
    @match = Match.find(params[:match_id])
  end

  def show
    @match = Match.find(params[:id])
  end

end
