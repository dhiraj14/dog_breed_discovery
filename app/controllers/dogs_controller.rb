class DogsController < ApplicationController
  before_action :validate_breed_param, only: :fetch_image

  def fetch_image
    image_url = DogImageService.new(breed_param).fetch_random_image
    render json: { image_url: image_url }
  rescue DogImageService::FetchError => e
    render json: { error: e.message }, status: :bad_gateway
  end

  private

  def breed_param
    params[:breed]
  end

  def validate_breed_param
    render json: { error: 'Breed parameter is required' }, status: :bad_request unless breed_param.present?
  end
end
