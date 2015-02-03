require 'spec_helper'

feature 'Anonymous User visits the site and enters an ugly URL' do
  scenario 'they get back a beautiful one', js: true do
    visit root_path

    fill_in 'url[original]', with: 'https://www.twitter.com'
    click_button 'Make Beautiful'
    sleep(0.5)
    url = Url.find_by(original: 'https://www.twitter.com')
    input = find_field('url[original]').value

    expect(page).to have_content "Beautiful URL:"
    expect(input).to have_content url_path(url)
  end

  scenario 'that has already been made beautiful', js: true do
    Url.create!(original: 'https://www.twitter.com')
    visit root_path

    fill_in 'url[original]', with: 'https://www.twitter.com'
    click_button 'Make Beautiful'
    sleep(0.5)
    urls = Url.all

    expect(urls.count).to eq 1
  end

  scenario 'they click the beautiful one' do
    url = Url.create!(original: 'https://www.twitter.com')
    visit url_path(url)

    expect(current_url).to eq 'https://www.twitter.com/'
  end

  scenario 'they expected the most popular links' do
  end

  scenario 'they expected the newest links' do
  end
end
