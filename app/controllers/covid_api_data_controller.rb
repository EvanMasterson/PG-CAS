class CovidApiDataController < ApplicationController
  before_action :set_covid_api_data, only: [:show, :edit, :update, :destroy]

  # GET /covid_api_data
  # GET /covid_api_data.json
  def index
    @covid_api_data = CovidApiData.all
  end

  # GET /covid_api_data/1
  # GET /covid_api_data/1.json
  def show
  end

  # GET /covid_api_data/new
  def new
    @covid_api_data = CovidApiData.new
  end

  # GET /covid_api_data/1/edit
  def edit
  end

  # POST /covid_api_data
  # POST /covid_api_data.json
  def create
    @covid_api_data = CovidApiData.new(covid_api_data_params)

    respond_to do |format|
      if @covid_api_data.save
        format.html { redirect_to @covid_api_data, notice: 'Covid api data was successfully created.' }
        format.json { render :show, status: :created, location: @covid_api_data }
      else
        format.html { render :new }
        format.json { render json: @covid_api_data.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /covid_api_data/1
  # PATCH/PUT /covid_api_data/1.json
  def update
    respond_to do |format|
      if @covid_api_data.update(covid_api_data_params)
        format.html { redirect_to @covid_api_data, notice: 'Covid api data was successfully updated.' }
        format.json { render :show, status: :ok, location: @covid_api_data }
      else
        format.html { render :edit }
        format.json { render json: @covid_api_data.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /covid_api_data/1
  # DELETE /covid_api_data/1.json
  def destroy
    @covid_api_data.destroy
    respond_to do |format|
      format.html { redirect_to covid_api_data_url, notice: 'Covid api data was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_covid_api_data
      @covid_api_data = CovidApiData.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def covid_api_data_params
      params.require(:covid_api_data).permit(:payload)
    end
end
