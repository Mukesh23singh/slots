class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]


  # GET /users/1
  def show_slots
    render json: @user
  end

  # POST /users
  def create_slots
    @user = User.new
    @slots = []
    @user.errors.add(:base, 'Name cannot be blank') if params[:name].blank?
    @user.errors.add(:base, 'Start_time cannot be blank') if params[:start_time].blank?
    @user.errors.add(:base, 'End_time cannot be blank') if params[:end_time].blank?
    @user.errors.add(:base, 'Capacity cannot be blank') if params[:capacity].blank?

    start_time_params = params[:start_time].split(':')
    end_time_params = params[:end_time].split(':')
    time = DateTime.now.change(hour: start_time_params[0].to_i, min: start_time_params[1].to_i).to_i..DateTime.now.change(hour: end_time_params[0].to_i, min: end_time_params[1].to_i).to_i
    time_array = time.to_a
    minutes = (((Time.at(time_array[-1]) - Time.at(time_array[0])))/60).to_i
    if minutes.modulo(15) != 0 || ![15, 30,45, 0].include?(0) || ![15, 30,45, 0].include?(15)
      @user.errors.add(:base, 'Start Time, End Time and Minutes should be in multiple of 15')
      return render json: @user.errors, status: :unprocessable_entity
    end
    time.step(15.minutes).each do |time|
      @slots << Time.at(time)
    end
    (1..params[:capacity].to_i).to_a.in_groups_of((@slots.count)) do |group|

    end
    @slots.reverse.each do |slot|

    end
    render json: @slots
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:name])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name)
    end
end
