class LeaguesController < ApplicationController
  def index
    @leagues = League.all
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(params[:league])

    if @league.save
      flash[:success] = 'League created'
      redirect_to leagues_path
    else
      render :new
    end
  end

  def edit
    @league = League.find(params[:id])
  end

  def show
    @league = League.find(params[:id])
  end

  def grid
  end

end
