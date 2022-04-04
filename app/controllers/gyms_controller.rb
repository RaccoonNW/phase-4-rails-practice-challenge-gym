class GymsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def index
    render json: Gym.all 
  end

  def show
    gym = find_gym
    render json: gym
  end

  # def create
  #   gym = Gym.create!(gym_params)
  #   render json: gym
  # end

  def update
    gym = find_gym
    gym.update!(gym_params)
    render json: gym, status: :accepted
  end

  def destroy
    gym = find_gym
    gym.destroy
    head :no_content
  end

  def find_gym
    gym = Gym.find(params[:id])
  end

  def gym_params
    params.permit(:name, :address)
  end

  def render_not_found_response
    render json: { error: "404: Gym not found" }, status: :not_found
  end

  def render_unprocessable_entity(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
