class InfoController < ApplicationController
  def coviddata
    if params[:location].to_s.present?
      @location = params[:location]
      existingData = CovidApiData.where("payload->>'location' = ?", @location)

      # If data already exists in DB retrieve it, else hit the API and store the response only if it has valid data
      if !existingData.empty?
        @response = existingData.first.payload["data"]
        puts @response
      else
        @response = Api.getCovidData(@location)
        puts @response
        if  @response.empty? || @response.instance_of?(Hash)
          @response = {"message"=>"Not Found"}
        else
          CovidApiData.create(payload: {location: @location, data: @response})
        end
      end
    else
      redirect_to(root_url)
    end
  end
end
