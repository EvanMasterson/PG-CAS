class ApiController < SecuredController
  skip_before_action :authorize_request, only: [:coviddata, :retrieveApiData]
  # protect_from_forgery unless: -> { request.format.json? }

  def coviddata
    if params[:location].to_s.present?
      location = params[:location]
      existingData = CovidApiData.find_by("payload->>'location' = ?", location)
      # If data already exists in DB retrieve it, else hit the API and store the response only if it has valid data
      if !existingData.nil?
        response = existingData.payload["data"]
      else
        response = ApiController.retrieveApiData(location)
      end
      UpdateDataJob.perform_later(existingData, location, response)
      render json: response, status: :ok
    else
      redirect_to(root_url)
    end
  end

  def self.retrieveApiData(location)
    apiData = Api.getCovidData(location)
    if apiData.empty? || apiData.instance_of?(Hash)
      apiData = {"message"=>"Not Found"}
    end 
    return apiData
  end

  # curl -H "authorization: bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InpDRFgxNmFRWlZWV0pIZF9zdjZjVSJ9.eyJpc3MiOiJodHRwczovL2Rldi1xZnI3N3E3Ni5ldS5hdXRoMC5jb20vIiwic3ViIjoiZ29vZ2xlLW9hdXRoMnwxMDgyMDQyNzU0OTg1MDcxMDg3OTMiLCJhdWQiOlsiaHR0cHM6Ly9yYWlscy1zZWN1cmUtYXBpIiwiaHR0cHM6Ly9kZXYtcWZyNzdxNzYuZXUuYXV0aDAuY29tL3VzZXJpbmZvIl0sImlhdCI6MTU5Njg5MTMwMSwiZXhwIjoxNTk2OTc3NzAxLCJhenAiOiJKUTV1b0E4d2l1U3NaNVozNG9kZExTR2IyZGZuMnNKNiIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwifQ.o7-qjHdH6hlqoheNUo9pdCoLf5XP2nReUCv7iCJnY6wrBT-gLBfhxbOacrVdraLHMkra4vjMzF8vRJfFaOidldokOgl6w9-uS_8ZmH9NikpuDAQLDXYVxQJOKJfGBoVpsUeTZCYb8t6GCrp3zqrsg9EAiTQPxqQVUsz4fpekz6hP1u8ZuS1NwZaI9lzJm7H2n11UEbXlTHuFPSL82AHMlYQNz6pnCP8Ksydub7hCpiygmqg0gK-6uD3pYkMYceG5bjr7oRovLNvFQMYLJaQUt5zfWqTE3DolkdkLDOUZArX7nnEuU5oWKUkZanvLcJch8bWYCg-SKBJU8zIW6zBl4A" -d '{"key": "value"}' -X POST http://localhost:3000/api/updaterisklevel
  def updateApiDataWithRiskLevel
    render json: request.body.read, status: :ok
  end
end
