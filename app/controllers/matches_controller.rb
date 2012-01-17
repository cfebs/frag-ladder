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
      redirect_to matches_path, :success => 'Match saved'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

end
