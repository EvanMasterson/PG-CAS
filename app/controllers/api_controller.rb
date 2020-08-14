class ApiController < SecuredController
  skip_before_action :authorize_request, only: [:retrieve_covid_data, :retrieve_data_from_external_api]
  # protect_from_forgery unless: -> { request.format.json? }

  def retrieve_covid_data
    if params[:location].to_s.present?
      location = params[:location]
      existingData = CovidApiData.find_by("payload->>'location' = ?", location)
      # If data already exists in DB retrieve it, else hit the API and store the response only if it has valid data
      if !existingData.nil?
        response = existingData.payload["data"]
        binding.pry
      else
        response = ApiController.retrieve_data_from_external_api(location)
      end
      UpdateDataJob.perform_later(existingData, location, response)
      render json: response, status: :ok
    else
      payload = { "error" => "Invalid request"}
      render json: payload, status: :bad_request
    end
  end

  def self.retrieve_data_from_external_api(location)
    apiData = Api.getCovidData(location)
    if apiData.empty? || apiData.instance_of?(Hash)
      apiData = {"message"=>"Not Found"}
    end 
    return apiData
  end

  # curl example
  # curl -H "authorization: bearer token_goes_here" -X PUT 'http://localhost:3000/api/update/data?has_symptoms=yes&location=ireland'
  def update_data_with_symptoms
    if params[:location].present? && params[:has_symptoms].present?
      # TODO update the covid data by location with has_symptoms


      payload = { "success" => "Data updated successfully"}
      render json: payload, status: :ok
    else
      payload = { "error" => "Invalid request"}
      render json: payload, status: :bad_request
    end
  end
end
