require 'test_helper'

class SlotTimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @slot_time = slot_times(:one)
  end

  test "should get index" do
    get slot_times_url, as: :json
    assert_response :success
  end

  test "should create slot_time" do
    assert_difference('SlotTime.count') do
      post slot_times_url, params: { slot_time: { capacity: @slot_time.capacity, end_time: @slot_time.end_time, start_time: @slot_time.start_time } }, as: :json
    end

    assert_response 201
  end

  test "should show slot_time" do
    get slot_time_url(@slot_time), as: :json
    assert_response :success
  end

  test "should update slot_time" do
    patch slot_time_url(@slot_time), params: { slot_time: { capacity: @slot_time.capacity, end_time: @slot_time.end_time, start_time: @slot_time.start_time } }, as: :json
    assert_response 200
  end

  test "should destroy slot_time" do
    assert_difference('SlotTime.count', -1) do
      delete slot_time_url(@slot_time), as: :json
    end

    assert_response 204
  end
end
