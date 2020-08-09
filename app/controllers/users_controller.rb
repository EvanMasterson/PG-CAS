class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    user_id = current_user.select(:id).first.id
    @user = User.find([user_id])
  	@user_details = session[:userinfo]
    binding.pry
  end

  # GET /users/new
  # def new
  #   @user = User.new
  # end

  # GET /users/1/edit
  def edit
    user_id = current_user.select(:id).first.id
  	@user = User.find([user_id])
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    user_id = current_user.select(:id).first.id
    @user = User.find([user_id])
    @user_object = User.where(id: @user.map(&:id))
    respond_to do |format|
      if @user_object.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  # def destroy
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      user_id = current_user.select(:id).first.id
      @user = User.find([user_id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {})
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :country, :pre_existing_conditions => [])
    end
end
