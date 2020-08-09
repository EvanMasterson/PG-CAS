class WelcomeController < ApplicationController
  include HTTParty
  def index
  end

  def retrieveData
    if params[:location].to_s.present?
      location = params[:location]
      host = Rails.env.production? ? "https://ncicloud.live" : "http://localhost:3000"
      url="#{host}/api/coviddata?location=#{location}"
      response = HTTParty.get(url)
      responsebody = JSON.parse(response.body)

      render json: responsebody, status: :ok
    else
      redirect_to root_url, notice: "Location was empty"
    end
  end
end
