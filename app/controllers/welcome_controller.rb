class WelcomeController < ApplicationController
  include HTTParty
  
  before_action :current_user

  def index
  end

  def retrieve_data
    if params[:location].to_s.present?
      location = params[:location]
      host = Rails.env.production? ? "https://ncicloud.live" : "http://localhost:3000"
      url="#{host}/api/coviddata?location=#{location}"
      response = HTTParty.get(url)
      responsebody = JSON.parse(response.body)

      @active = responsebody.map { |r| [r["Date"], r["Active"]] }
      @deaths = responsebody.map { |r| [r["Date"], r["Deaths"]] }
      
      respond_to do |format|
        format.js
      end
      # render json: @responsebody, status: :ok
    else
      redirect_to root_url, alert: "Location was empty"
    end
  end
end
