class UpdateDataJob < ApplicationJob
  queue_as :default

  # Performs updates to database records when it see's fit to not hinder app performance
  def perform(existingData, location, response)
    if !existingData.nil?
      if existingData.updated_at > 1.day.ago
        existingData.update(payload: {location: location, data: ApiController.retrieveApiData(location)})
      end
    else
      CovidApiData.create(payload: {location: location, data: response})
    end
  end
end
