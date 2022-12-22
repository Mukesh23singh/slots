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
    return render json: @user.errors, status: :unprocessable_entity if check_params_present?
    start_time_params = params[:start_time].split(':')
    end_time_params = params[:end_time].split(':')
    time = parse_time(start_time_params, end_time_params)
    check_multiple_of_15(time)
    return render json: @user.errors, status: :unprocessable_entity if !@user.errors.blank?
    time.step(15.minutes).each do |time|
      @slots << Time.at(time)
    end
    @slots = @slots[0..params[:capacity].to_i].to_a.reverse
    slot_times_attributes = []
    in_groups_of = (@slots.length) -1
    (1..params[:capacity].to_i).to_a.in_groups_of(in_groups_of) do |groups|
      groups.each_with_index do |group, index|
        if !group.blank?
          if slot_times_attributes[index].blank?
            slot_times_attributes.insert(index, {start_time: @slots[index + 1], end_time: @slots[index], capacity: 1})
          else
            slot_times_attributes[index].merge!({start_time: @slots[index + 1], end_time: @slots[index], capacity: slot_times_attributes[index][:capacity].to_i + 1})
          end
        else
          break
        end
      end
    end

    @user = User.find_or_initialize_by(name: params[:name])
    if @user.save
      @user.slot_times.create(slot_times_attributes)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_name(params[:name])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name)
    end

    def parse_time(start_time_params, end_time_params)
      DateTime.now.change(hour: start_time_params[0].to_i,
      min: start_time_params[1].to_i).to_i..DateTime.now.change(hour: end_time_params[0].to_i,
      min: end_time_params[1].to_i).to_i
    end

    def check_params_present?
      @user.errors.add(:base, 'Name cannot be blank') if params[:name].blank?
      @user.errors.add(:base, 'Start_time cannot be blank') if params[:start_time].blank?
      @user.errors.add(:base, 'End_time cannot be blank') if params[:end_time].blank?
      @user.errors.add(:base, 'Capacity cannot be blank') if params[:capacity].blank?
      return !@user.errors.blank?
    end

    def check_multiple_of_15(time)
      begin
        time_array = time.to_a
        minutes = (((Time.at(time_array[-1]) - Time.at(time_array[0])))/60).to_i
        if minutes.modulo(15) != 0 || ![15, 30,45, 0].include?(0) || ![15, 30,45, 0].include?(15)
          @user.errors.add(:base, 'Start Time, End Time and Minutes should be in multiple of 15')
        end
        if minutes > 180
          @user.errors.add(:base, 'You can add slot in window of 3 hours')
        end
      rescue => error
         @user.errors.add(:base, 'End time should not be lesser than start time')
      end
    end
end
