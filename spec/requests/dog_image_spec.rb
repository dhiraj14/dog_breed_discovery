require 'rails_helper'

RSpec.describe 'DogImageController', type: :request do
  describe 'GET /dog_image' do
    let(:breed) { 'bulldog' }
    let(:dog_image_service_double) { instance_double(DogImageService) }

    before do
      allow(DogImageService).to receive(:new).with(breed).and_return(dog_image_service_double)
    end

    context 'when a valid breed is provided' do
      let(:image_url) { 'https://dog.ceo/api/breed/dog.jpg' }

      before do
        allow(dog_image_service_double).to receive(:fetch_random_image).and_return(image_url)
        get "/dog_image?breed=#{breed}"
      end

      it 'returns a successful response with the image URL' do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({ 'image_url' => image_url })
      end
    end

    context 'when the DogImageService raises a FetchError' do
      before do
        allow(dog_image_service_double).to receive(:fetch_random_image).and_raise(DogImageService::FetchError, 'Error fetching image')
        get "/dog_image?breed=#{breed}"
      end

      it 'returns a bad gateway status with an error message' do
        expect(response).to have_http_status(:bad_gateway)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Error fetching image' })
      end
    end

    context 'when the breed parameter is missing' do
      it 'returns a bad request status with an error message' do
        get "/dog_image"
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Breed parameter is required' })
      end
    end
  end
end
