class InfoController < ApplicationController
  def coviddata
    if params[:location].to_s.present?
      @location = params[:location]
      existingData = CovidApiData.find_by("payload->>'location' = ?", @location)
      # If data already exists in DB retrieve it, else hit the API and store the response only if it has valid data
      if !existingData.nil?
        if  existingData.updated_at > 1.day.ago
          existingData.update(payload: {location: @location, data: self.retrieveApiData})
        end
        @response = existingData.payload["data"]
      else
        @response = self.retrieveApiData
        CovidApiData.create(payload: {location: @location, data: @response})
      end
      render json: @response, status: :ok
    else
      redirect_to(root_url)
    end
  end

  def retrieveApiData
    apiData = Api.getCovidData(@location)
    if apiData.empty? || apiData.instance_of?(Hash)
      apiData = {"message"=>"Not Found"}
    end
    return apiData
  end
end
