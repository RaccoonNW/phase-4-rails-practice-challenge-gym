class ClientsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity


  def index
    render json: Client.all 
  end

  def show
    client = find_client
    render json: client
  end

  # def create
  #   client = Client.create!(client_params)
  #   render json: client
  # end

  def update
    client = find_client
    client.update!(client_params)
    render json: client, status: :accepted
  end

  # def destroy
  #   client = find_client
  #   client.destroy
  #   head :no_content
  # end

  private

  def find_client
    client = Client.find(params[:id])
  end

  def client_params
    params.permit(:name, :age)
  end

  def render_not_found_response
    render json: { error: "Client not found" }, status: :not_found
  end

  def render_unprocessable_entity(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

end
