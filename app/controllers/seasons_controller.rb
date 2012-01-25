class SeasonsController < ApplicationController
  def new
    @league = League.find(params[:id])
    @season = @league.seasons.build
  end

  def create
    @season = Season.new(params[:season])
    if @season.save
      flash[:success] = 'Season created'
    else
      render :new
    end
  end

  def edit
  end

  def show
    @season = Season.find(params[:id])
    @teams = @season.teams
    @teams.sort! { |a,b|
      # http://www.ruby-forum.com/topic/162413
      comp = b.total_points <=> a.total_points
      comp.zero? ? b.win_percentage <=> a.win_percentage : comp
    }
  end

  def index
    @league = League.find(params[:id])
    @seasons = @league.seasons
  end

end
