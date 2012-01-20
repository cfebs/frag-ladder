class MatchesController < ApplicationController
  def index
    @matches = Match.all
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(params[:match])

    if @match.save
      #redirect_to matches_player_stats
      redirect_to new_match_member_match_record_path(@match), :success => 'Match saved'
    else
      render :new
    end
  end

  def show
    @match = Match.find(params[:id])
  end

  def edit
  end

  def update
    @match = Match.find(params[:id])
    if @match.update_attributes(params[:match])
      redirect_to match_path(@match)
    else
      render :new
    end

  end

end
