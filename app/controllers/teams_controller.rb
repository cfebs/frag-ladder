class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(params[:team])
    if @team.save
      redirect_to team_path(@team), :success => 'Team created'
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
    @leagues = @team.leagues
  end

end
