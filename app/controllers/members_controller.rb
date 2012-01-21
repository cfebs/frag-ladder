class MembersController < ApplicationController
  def index
    @team = Team.find(params[:team_id])
    @members = @team.members
  end

  def new
    @team = Team.find(params[:team_id])
    @team_member = @team.members.build
  end

  def create
    @team = Team.find(params[:team_id])
    @member = @team.members.new(params[:member])
    @team.members << @member

    if @member.save
      flash[:success] = 'Member created'
      redirect_to team_path(@team)
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

  def grid
  end

end
