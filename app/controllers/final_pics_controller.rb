class FinalPicsController < ApplicationController
  before_action :set_final_pics, only: [:show, :edit, :update, :destroy]

  def index
    @final_pics = policy_scope(FinalPic)
  end

  def show
    @final_pic = FinalPic.find(params[:id])
  end

  def new
    @final_pic = FinalPic.new
    @benchmark_pic = BenchmarkPic.find(params[:benchmark_pic_id])
    authorize @final_pic
  end

  def create
    @final_pic = FinalPic.new(final_pic_params) #FinalPic.new(final_pic_params)
    @final_pic.user = current_user
    @final_pic.benchmark_pic = BenchmarkPic.find(params[:benchmark_pic_id])
    @final_pic.location = Location.second
    authorize @final_pic
    @final_pic.save
    redirect_to final_pic_path(@final_pic)
  end

  def edit
    @final_pic = FinalPic.find(params[:id])
    @final_pic.user = current_user
    @benchmark_pic = @final_pic.benchmark_pic
    authorize @final_pic
    authorize @benchmark_pic
  end

  def update
    @final_pic = FinalPic.find(params[:id])
    @benchmark_pic = @final_pic.benchmark_pic
    @final_pic.update(final_pic_params)
    redirect_to final_pic_path(@final_pic)
  end

  def destroy
    @final_pic = FinalPic.find(params[:id])
    @final_pic.destroy
    redirect_to final_pics_path
  end

  private
  # same as benchmark pics I added this one for callback
  def set_final_pics
    @final_pic = FinalPic.find(params[:id])
    authorize @final_pic
  end

  def final_pic_params
    params.require(:final_pic).permit(:benchmark_pic_id, :photo, :id)
  end
end
