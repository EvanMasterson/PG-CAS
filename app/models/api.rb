class Api
  include HTTParty

  # https://covid19api.com/
  # https://documenter.getpostman.com/view/10808728/SzS8rjbc?version=latest
  def self.getCovidData(location)
    url="https://api.covid19api.com/total/country/#{location}"
    response = HTTParty.get(url)
    responsebody = JSON.parse(response.body)
    return responsebody
  end
end