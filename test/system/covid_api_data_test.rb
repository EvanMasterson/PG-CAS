require "application_system_test_case"

class CovidApiDataTest < ApplicationSystemTestCase
  setup do
    @covid_api_ddata = covid_api_data(:one)
  end

  test "visiting the index" do
    visit covid_api_data_url
    assert_selector "h1", text: "Covid Api Data"
  end

  test "creating a Covid api ddata" do
    visit covid_api_data_url
    click_on "New Covid Api Ddata"

    fill_in "Payload", with: @covid_api_ddata.payload
    click_on "Create Covid api ddata"

    assert_text "Covid api ddata was successfully created"
    click_on "Back"
  end

  test "updating a Covid api ddata" do
    visit covid_api_data_url
    click_on "Edit", match: :first

    fill_in "Payload", with: @covid_api_ddata.payload
    click_on "Update Covid api ddata"

    assert_text "Covid api ddata was successfully updated"
    click_on "Back"
  end

  test "destroying a Covid api ddata" do
    visit covid_api_data_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Covid api ddata was successfully destroyed"
  end
end
