class GymsController < ApplicationController
  before_action :set_gym, only: %i[ show edit update destroy ]

  # GET /gyms or /gyms.json
  def index
    @gyms = Gym.all
  end

  # GET /gyms/1 or /gyms/1.json
  def show
  end

  # GET /gyms/new
  def new
    @gym = Gym.new
  end

  # GET /gyms/1/edit
  def edit
  end

  # POST /gyms or /gyms.json
  def create
    @gym = Gym.new(gym_params)

    respond_to do |format|
      if @gym.save
        format.html { redirect_to @gym, notice: "Gym was successfully created." }
        format.json { render :show, status: :created, location: @gym }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @gym.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gyms/1 or /gyms/1.json
  def update
    respond_to do |format|
      if @gym.update(gym_params)
        format.html { redirect_to @gym, notice: "Gym was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @gym }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @gym.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gyms/1 or /gyms/1.json
  def destroy
    @gym.destroy!

    respond_to do |format|
      format.html { redirect_to gyms_path, notice: "Gym was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gym
      @gym = Gym.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def gym_params
      params.expect(gym: [ :name, :corporate_name, :subdomain ])
    end
end
