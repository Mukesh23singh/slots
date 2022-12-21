class SlotTimesController < ApplicationController
  before_action :set_slot_time, only: [:show, :update, :destroy]

  # GET /slot_times
  def index
    @slot_times = SlotTime.all

    render json: @slot_times
  end

  # GET /slot_times/1
  def show
    render json: @slot_time
  end

  # POST /slot_times
  def create
    @slot_time = SlotTime.new(slot_time_params)

    if @slot_time.save
      render json: @slot_time, status: :created, location: @slot_time
    else
      render json: @slot_time.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /slot_times/1
  def update
    if @slot_time.update(slot_time_params)
      render json: @slot_time
    else
      render json: @slot_time.errors, status: :unprocessable_entity
    end
  end

  # DELETE /slot_times/1
  def destroy
    @slot_time.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slot_time
      @slot_time = SlotTime.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def slot_time_params
      params.require(:slot_time).permit(:start_time, :end_time, :capacity)
    end
end
