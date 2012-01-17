class MembersController < ApplicationController
  def index
    @team = Team.find(params[:team_id])
    @members = @team.members
  end

  def new
    @team = Team.find(params[:team_id])
  end

  def create
    @team = Team.find(params[:team_id])
    @member = @team.members.create(params[:member])
    if @member.valid?
      redirect_to team_path(@team), :success => 'Member created'
    else
      render :new
    end
  end

  def edit
    @member = Team.find(params[:id])
  end

  def update
    @member = Team.find(params[:id])
    if @member.update_attributes(params[:team])
      redirect_to member_path(@team), :success => 'member updated'
    else
      render :edit
    end
  end

  def show
    @member = Team.find(params[:id])
  end

end
