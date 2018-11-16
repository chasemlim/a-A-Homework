class BandsController < ApplicationController

  def index # For view iterate thru @bands
    @bands = Band.all
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.create(band_params)

    redirect_to band_url(@band) if @band.save
  end

  def edit
    @band = Band.new
    render :edit
  end

  def update
    @band = Band.find_by(params[:id])

    
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end
end
