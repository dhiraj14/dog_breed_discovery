require 'rails_helper'

RSpec.describe DogImageService do
  describe '#fetch_random_image' do
    subject(:service) { described_class.new(breed) }

    context 'with a single word breed' do
      let(:breed) { 'bulldog' }

      before do
        stub_request(:get, "#{DogImageService::API_BASE_URL}/#{breed}/images/random")
          .to_return(status: 200, body: { status: 'success', message: 'http://example.com/dog.jpg' }.to_json)
      end

      it 'fetches a random dog image URL' do
        expect(service.fetch_random_image).to eq('http://example.com/dog.jpg')
      end
    end

    context 'with a multi-word breed' do
      let(:breed) { 'german shepherd' }

      it 'fetches a random dog image URL using a reversed and slashed breed name' do
        stub_request(:get, "#{DogImageService::API_BASE_URL}/shepherd/german/images/random")
          .to_return(status: 200, body: { status: 'success', message: 'http://example.com/shepherd.jpg' }.to_json)

        expect(service.fetch_random_image).to eq('http://example.com/shepherd.jpg')
      end
    end

    context 'when the API call is unsuccessful' do
      let(:breed) { 'bulldog' }

      before do
        stub_request(:get, "#{DogImageService::API_BASE_URL}/#{breed}/images/random")
          .to_return(status: 200, body: { status: 'error' }.to_json)
      end

      it 'raises a FetchError' do
        expect { service.fetch_random_image }.to raise_error(DogImageService::FetchError)
      end
    end

    context 'when there is a network error' do
      let(:breed) { 'bulldog' }

      before do
        stub_request(:get, "#{DogImageService::API_BASE_URL}/#{breed}/images/random")
          .to_raise(StandardError.new('Network error'))
      end

      it 'raises a StandardError' do
        expect { service.fetch_random_image }.to raise_error(StandardError, 'Network error')
      end
    end
  end
end
