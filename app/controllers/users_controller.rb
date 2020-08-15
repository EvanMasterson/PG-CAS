class UsersController < ApplicationController
  before_action :current_user

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  # def new
  #   @user = User.new
  # end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @current_user.update(user_params)
        host = Rails.env.production? ? "https://ncicloud.live" : "http://localhost:3000"
        url="#{host}/api/update/data?has_symptoms=#{@current_user.has_symptoms}&location=#{@current_user.country}"
        auth_header = { "Authorization" => "bearer #{@current_user.bearer_token}"}
        HTTParty.put(url, :headers => auth_header)

        format.html { redirect_to dashboard_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: dashboard_path }
      else
        format.html { render :edit }
        format.json { render json: @current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @current_user.present?
      @current_user.destroy
      @current_user.authorizations.destroy_all
      respond_to do |format|
        format.html { redirect_to logout_path, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {})
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit!
      #(:name, :email, :country, :pre_existing_conditions, :age, :has_symptoms, :risk_score)
    end
end
