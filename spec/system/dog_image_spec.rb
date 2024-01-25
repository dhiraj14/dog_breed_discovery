require 'rails_helper'

RSpec.describe 'Dog image fetching', type: :system, js: true do
  let(:breed) { 'bulldog' }
  let(:image_url) { 'https://images.dog.ceo/breeds/bulldog/n02101006_1016.jpg' }

  it 'displays an image of the specified breed' do
    stub_request(:get, "https://dog.ceo/api/breed/#{breed}/images/random")
      .to_return(status: 200, body: { status: 'success', message: image_url }.to_json)

    visit '/' 

    fill_in 'breed', with: breed
    click_button 'Submit'

    expect(page).to have_css("img[src='#{image_url}']")
    expect(page).to have_content(breed.capitalize)
  end

  context 'when the breed is not found' do
    let(:breed) { 'unknownbreed' }

    it 'shows an error message' do
      stub_request(:get, "https://dog.ceo/api/breed/#{breed}/images/random")
        .to_return(status: 200, body: { status: 'error' }.to_json)

      visit '/'
      fill_in 'breed', with: breed
      click_button 'Submit'

      expect(page).to have_content('Error fetching image')
    end
  end
end
