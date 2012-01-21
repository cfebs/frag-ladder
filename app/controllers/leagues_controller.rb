class LeaguesController < ApplicationController
  def index
    @leagues = League.all
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(params[:league])
    # TODO add something for active leagues, overwrite existing actives

    if @league.save
      flash[:success] = 'League created'
      redirect_to leagues_path
    else
      render :new
    end
  end

  def edit
  end

end
