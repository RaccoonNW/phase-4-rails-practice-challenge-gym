class MembershipsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def index
    render json: Membership.all
  end

  # def show
  #   membership = find_membership
  #   render json: membership
  # end

  def create
    membership = Membership.create!(membership_params)
    render json: membership
  end

  # def update
  #   membership = find_membership
  #   membership.update!(membership_params)
  #   render json: membership
  # end

  def destroy
    membership = find_membership
    membership.destroy
    head :no_content
  end

  private

  def find_membership
    membership = Membership.find(params[:id])
  end

  def membership_params
    params.permit(:gym_id, :client_id, :charge)
  end

  def render_unprocessable_entity(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: {error: "Membership not found" }, status: :not_found
  end

end
