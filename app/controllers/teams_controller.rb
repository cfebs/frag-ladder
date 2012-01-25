class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def new
    @season = Season.find(params[:season_id])
    @team = @season.teams.build
  end

  def create
    @season = Season.find(params[:season_id])
    @team = @season.teams.new(params[:team])

    if @team.save
      flash[:success] = 'Team created'
      redirect_to season_team_path(@season, @team)
    else
      render :new
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])

    if @team.update_attributes(params[:team])
      redirect_to team_path(@team), :success => 'Team updated'
    else
      render :edit
    end
  end

  def show
    @team = Team.find(params[:id])
  end

end
