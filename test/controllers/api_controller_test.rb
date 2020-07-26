require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest

  test "should get coviddata" do
    get api_coviddata_url
    assert_response :success
  end

end
