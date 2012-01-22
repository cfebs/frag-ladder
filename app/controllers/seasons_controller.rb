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
  end

  def index
    @league = League.find(params[:id])
    @seasons = @league.seasons
  end

end
