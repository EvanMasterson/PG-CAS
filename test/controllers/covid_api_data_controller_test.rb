require 'test_helper'

class CovidApiDataControllerTest < ActionDispatch::IntegrationTest
  setup do
    @covid_api_ddata = covid_api_data(:one)
  end

  test "should get index" do
    get covid_api_data_url
    assert_response :success
  end

  test "should get new" do
    get new_covid_api_ddata_url
    assert_response :success
  end

  test "should create covid_api_ddata" do
    assert_difference('CovidApiDdata.count') do
      post covid_api_data_url, params: { covid_api_ddata: { payload: @covid_api_ddata.payload } }
    end

    assert_redirected_to covid_api_ddata_url(CovidApiDdata.last)
  end

  test "should show covid_api_ddata" do
    get covid_api_ddata_url(@covid_api_ddata)
    assert_response :success
  end

  test "should get edit" do
    get edit_covid_api_ddata_url(@covid_api_ddata)
    assert_response :success
  end

  test "should update covid_api_ddata" do
    patch covid_api_ddata_url(@covid_api_ddata), params: { covid_api_ddata: { payload: @covid_api_ddata.payload } }
    assert_redirected_to covid_api_ddata_url(@covid_api_ddata)
  end

  test "should destroy covid_api_ddata" do
    assert_difference('CovidApiDdata.count', -1) do
      delete covid_api_ddata_url(@covid_api_ddata)
    end

    assert_redirected_to covid_api_data_url
  end
end
