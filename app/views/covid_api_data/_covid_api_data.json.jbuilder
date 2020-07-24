json.extract! covid_api_ddata, :id, :payload, :created_at, :updated_at
json.url covid_api_ddata_url(covid_api_ddata, format: :json)
